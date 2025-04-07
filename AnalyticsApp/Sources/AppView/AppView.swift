import AppCore
import AccountListView
import ComposableArchitecture
import ChartView
import SelectorView
import SwiftUI

public struct AppView: View {
    @State var isLargeMode = false
    let store: StoreOf<AppCore>

    public init(store: StoreOf<AppCore>) {
      self.store = store
    }

    public var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                VStack {
                    ChartView(store: store)
                    SelectorView(store: store)
                        .padding(.bottom, 32)
                    Spacer()
                        .frame(height: 350)
                }
                AccountListView(store: store, isLargeMode: $isLargeMode)
                    .ignoresSafeArea(.all, edges: .bottom)
                    .padding(.top, isLargeMode ? 33 : 430)
            }
            .background(Color(.bgSample))
        }
    }
}

#Preview {
    AppView(store: Store(initialState: AppCore.State(), reducer: {
        AppCore()
    }))
}
