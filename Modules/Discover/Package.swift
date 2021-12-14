// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Discover",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Discover",
            targets: ["Discover"]),
    ],
    dependencies: [
        .package(url: "Interfaces", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Discover",
            dependencies: ["Interfaces"],
            path: "Sources"),
        .testTarget(
            name: "DiscoverTests",
            dependencies: ["Discover"]),
    ]
)
