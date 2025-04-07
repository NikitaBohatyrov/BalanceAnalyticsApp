import AppCore
import Charts
import ComposableArchitecture
import SwiftUI

public struct ChartView: View {
    @Bindable var store: StoreOf<AppCore>
    
    public init(store: StoreOf<AppCore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            GeometryReader { proxy in
                VStack(alignment: .center, spacing: 0) {
                    navigationTitle
                        .padding(.bottom, 13)
                    balance(viewStore)
                        .padding(.top, 12)
                        .padding(.bottom, 32)
                    createChart(viewStore)
                        .padding(.top, 22)
                    rangeSelector(viewStore, proxy)
                }
            }
        }
    }

    private var navigationTitle: some View {
        Text("Statistics")
            .font(.system(size: 17, weight: .semibold))
            .kerning(-0.5)
            .foregroundStyle(Color.white)
    }

    private func balance(_ viewStore: ViewStoreOf<AppCore>) -> some View {
        VStack(alignment: .center, spacing: 0) {
            if let lastDate = viewStore.state.slicedDataRange.last {
                Group {
                    Text("$").foregroundStyle(Color.white.opacity(0.6)) +
                    Text(lastDate.getFormattedBalance())
                        .foregroundStyle(Color.white)
                }
                .font(.system(size: 48, weight: .regular))
                .padding(.bottom, 4)
                Text(lastDate.getFormattedDate())
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.white.opacity(0.6))
            }
        }
    }

    private func rangeSelector(_ viewStore: ViewStoreOf<AppCore>, _ proxy: GeometryProxy) -> some View {
        let width = calculateWidth(viewStore)
        return HStack(alignment: .center, spacing: calculateSpacing(viewStore, proxy)) {
            ForEach(viewStore.state.selectedData, id: \.id) { item in
                if let selectedDate = viewStore.state.selectedDate, selectedDate == item {
                    RoundedRectangle(cornerRadius: 1)
                        .foregroundStyle(Color.white)
                        .frame(width: width, height: 8)
                } else {
                    RoundedRectangle(cornerRadius: 1)
                        .foregroundStyle(Color.white.opacity(0.24))
                        .frame(width: width, height: 8)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }

    private func calculateWidth(_ viewStore: ViewStoreOf<AppCore>) -> CGFloat {
        if viewStore.state.selectedData.count < 28 {
            return 2
        } else if 28...31 ~= viewStore.state.selectedData.count {
            return 1.5
        } else {
            return 1
        }
    }

    private func calculateSpacing(_ viewStore: ViewStoreOf<AppCore>, _ proxy: GeometryProxy) -> CGFloat {
        let padding: CGFloat = 40
        let itemWidth: CGFloat
        let screenWidth = proxy.size.width
        if viewStore.state.selectedData.count < 28 {
            itemWidth = 2
        } else if 28...31 ~= viewStore.state.selectedData.count {
            itemWidth = 1.5
        } else {
            itemWidth = 1
        }
        let totalItemWidth = itemWidth * CGFloat(viewStore.state.selectedData.count)
        let totalFreeSpace = screenWidth - totalItemWidth - padding
        return totalFreeSpace / CGFloat(viewStore.state.selectedData.count - 1)
    }

    private func createChart(_ viewStore: ViewStoreOf<AppCore>) -> some View {
        Chart {
            ForEach(viewStore.state.selectedData, id: \.id) { item in
                LineMark(x: .value("Date", item.date), y: .value("Amount", item.balance))
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(Color(.chartBase))
                    .symbol {
                        if let selectedDate = viewStore.state.selectedDate, selectedDate.id == item.id {
                            Circle()
                                .fill(Color(.gradient))
                                .frame(width: 15)
                        }
                    }
                AreaMark(x: .value("Date", item.date), y: .value("Amount", item.balance))
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [Color(.gradient).opacity(0.16), Color(.gradient).opacity(0)]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
            }
        }
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .chartGesture() { chart in
            DragGesture()
                .onChanged { value in
                    calculateGesturePosition(viewStore, chart, value)
                }
                .onEnded { value in
                    calculateGesturePosition(viewStore, chart, value)
                }
        }
        .chartOverlay { chartProxy in
            let points: [CGPoint] = viewStore.slicedDataRange.compactMap { item in
                return chartProxy.position(for: (item.date, item.balance))
            }
            CurvedLineView(points: points)
        }
    }

    private func calculateGesturePosition(
        _ viewStore: ViewStoreOf<AppCore>,
        _ chart: ChartProxy,
        _ value: DragGesture.Value
    ) {
        let position = CGPoint(
            x: value.startLocation.x + value.translation.width,
            y: value.startLocation.y
        )
        if let value = chart.value(at: position, as: (Date, Int).self) {
            let selectedValue = viewStore.state.selectedData.first { transaction in
                transaction.date.get(.day, .month, .year) == value.0.get(.day, .month, .year)
            }
            if let selectedValue {
                viewStore.send(.chartRangeSelected(selectedValue))
            }
        }
    }
}
