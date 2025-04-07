import AppCore
import AppView
import ComposableArchitecture
import SwiftUI

@main
struct BalanceAnalyticsAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    var body: some Scene {
        WindowGroup {
            AppView(store: appDelegate.store)
        }
    }
}
