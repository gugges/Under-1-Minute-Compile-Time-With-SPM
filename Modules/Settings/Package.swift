// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Settings",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Settings",
            targets: ["Settings"]),
    ],
    dependencies: [
        .package(url: "Interfaces", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Settings",
            dependencies: ["Interfaces"],
            path: "Sources"),
        .testTarget(
            name: "SettingsTests",
            dependencies: ["Settings"]),
    ]
)
