import AppCore
import ComposableArchitecture
import SwiftUI

@Reducer
public struct AccountDetails {
    public init() {}

    public struct State: Equatable {
        public var dataSource: AccountData
        public init(dataSource: AccountData) {
            self.dataSource = dataSource
        }
    }

    public enum Action {}
}
