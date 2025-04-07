import AppCore
import ComposableArchitecture
import SwiftUI

public struct SelectorView: View {
    @Bindable var store: StoreOf<AppCore>
    
    public init(store: StoreOf<AppCore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            HStack(alignment: .center, spacing: 4) {
                ForEach(DayRange.allCases, id: \.rawValue) { selection in
                    Text(selection.rawValue)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .overlay {
                            if viewStore.state.dayRange == selection {
                                RoundedRectangle(cornerRadius: 32)
                                    .foregroundStyle(Color.white.opacity(0.15))
                            } else {
                                Rectangle()
                                    .foregroundStyle(Color.clear)
                                    .contentShape(Rectangle())
                            }
                        }
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            viewStore.send(.selectDayRange(selection), animation: .easeInOut(duration: 0.3))
                        }
                }
            }
        }
    }
}
