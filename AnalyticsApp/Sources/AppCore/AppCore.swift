import ComposableArchitecture
import SwiftUI

@Reducer
public struct AppCore {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        var dataRepository = DataRepository()
        public var selectedData: [AccountData] = []
        public var slicedDataRange: [AccountData] = []
        public var selectedDate: AccountData?
        public var dayRange: DayRange = .month
        public init() {}
    }

    public enum Action: Sendable {
        case applicationLoaded
        case selectDayRange(DayRange)
        case chartRangeSelected(AccountData)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .applicationLoaded:
                state.dayRange = .month
                state.selectedData = state.dataRepository.getDataSlice(state: state)
                state.slicedDataRange = state.dataRepository.sliceFetchedData(state: state)
                state.selectedDate = state.slicedDataRange.last
                return .none
            case .chartRangeSelected(let date):
                state.selectedDate = date
                state.slicedDataRange = state.dataRepository.sliceFetchedData(state: state)
                return .none
            case .selectDayRange(let dayRange):
                guard dayRange != state.dayRange else { return .none }
                withAnimation(.easeOut(duration: 0.7)) {
                    state.dayRange = dayRange
                    state.selectedData = state.dataRepository.getDataSlice(state: state)
                    state.slicedDataRange = state.dataRepository.sliceFetchedData(state: state)
                }
                return .none
            }
        }
    }
}
