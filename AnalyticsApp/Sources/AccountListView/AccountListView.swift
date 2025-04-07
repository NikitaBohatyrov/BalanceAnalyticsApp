import AccountDetails
import AccountDetailsView
import AppCore
import ComposableArchitecture
import SwiftUI

public struct AccountListView: View {
    @Bindable var store: StoreOf<AppCore>
    @Binding var isLargeMode: Bool

    public init(store: StoreOf<AppCore>, isLargeMode: Binding<Bool>) {
        self.store = store
        self._isLargeMode = isLargeMode
    }

    public var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.white)
                    .cornerRadius(32, corners: [.topLeft, .topRight])
                VStack(alignment: .leading, spacing: 0) {
                    gestureIsland
                    accountLabel
                    accountList(viewStore)
                    Spacer()
                }
            }
        }
    }

    private var gestureIsland: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle())
                .frame(height: 25)
            RoundedRectangle(cornerRadius: 24)
                .frame(width: 54, height: 4)
                .foregroundStyle(Color.black.opacity(0.17))
                .padding(.vertical, 8)
        }
        .gesture(dragGesture)
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if isLargeMode && value.translation.height > 100 {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        isLargeMode = false
                    }
                } else if !isLargeMode && value.translation.height < -100 {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        isLargeMode = true
                    }
                }
            }
    }

    private var accountLabel: some View {
        Text("Accounts")
            .foregroundStyle(Color.black)
            .font(.system(size: 20, weight: .semibold))
            .padding(.horizontal, 20)
            .padding(.top, 28)
            .padding(.bottom, 8)
    }

    private func accountList(_ viewStore: ViewStoreOf<AppCore>) -> some View {
        VStack(alignment: .center, spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewStore.state.slicedDataRange) { item in
                    constructAccountRow(item, viewStore)
                }
            }
        }
    }

    private func constructAccountRow(_ data: AccountData, _ viewStore: ViewStoreOf<AppCore>) -> some View {
        NavigationLink {
            AccountDetailsView(
                store: Store(
                    initialState: AccountDetails.State(dataSource: data),
                    reducer: {
                        AccountDetails()
                    }
                )
            )
        } label: {
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Circle()
                        .frame(width: 48, height: 48)
                        .foregroundStyle(Color(.logoGray))
                        .overlay {
                            Text("LOGO")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(Color.white)
                        }
                    VStack(alignment: .leading, spacing: 0) {
                        Text(data.name)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color(.nameBlack))
                        Text(data.description)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(Color(.nameBlack).opacity(0.6))
                    }
                    .padding(.vertical, 12)
                    .padding(.leading, 16)
                    Spacer()
                    Text(data.getFormattedAmount())
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color(.nameBlack))
                }
                .padding(.horizontal, 16)
                if data != viewStore.state.selectedData.last {
                    Rectangle()
                        .foregroundStyle(Color(.nameBlack).opacity(0.12))
                        .frame(height: 0.5)
                        .padding(.leading, 64)
                }
            }
        }
    }
}
