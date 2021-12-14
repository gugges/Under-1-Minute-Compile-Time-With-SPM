// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]),
    ],
    dependencies: [
        .package(url: "Interfaces", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: ["Interfaces"],
            path: "Sources"),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]),
    ]
)
