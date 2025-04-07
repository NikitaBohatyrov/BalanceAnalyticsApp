import ComposableArchitecture
import Foundation
import SwiftUI

public class AppDelegate: NSObject, UIApplicationDelegate {
    public let store = Store(initialState: AppCore.State()) {
        AppCore()
    }

    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        store.send(.applicationLoaded)
        return true
    }
}
