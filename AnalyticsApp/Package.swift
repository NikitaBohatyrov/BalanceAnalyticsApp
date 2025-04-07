// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnalyticsApp",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "AppCore", targets: ["AppCore"]),
        .library(name: "AppView", targets: ["AppView"]),
        .library(name: "ChartView", targets: ["ChartView"]),
        .library(name: "SelectorView", targets: ["SelectorView"]),
        .library(name: "AccountListView", targets: ["AccountListView"]),
        .library(name: "AccountDetailsView", targets: ["AccountDetailsView"]),
        .library(name: "AccountDetails", targets: ["AccountDetails"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.19.0")
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "AppView",
            dependencies: [
                "AppCore",
                "ChartView",
                "SelectorView",
                "AccountListView",
            ]
        ),
        .target(
            name: "ChartView",
            dependencies: [
                "AppCore"
            ]
        ),
        .target(
            name: "SelectorView",
            dependencies: [
                "AppCore",
            ]
        ),
        .target(
            name: "AccountListView",
            dependencies: [
                "AppCore",
                "AccountDetailsView",
                "AccountDetails"
            ]
        ),
        .target(
            name: "AccountDetailsView",
            dependencies: [
                "AccountDetails"
            ]
        ),
        .target(
            name: "AccountDetails",
            dependencies: [
                "AppCore",
            ]
        )
    ]
)
