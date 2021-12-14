// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(url: "Interfaces", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: ["Interfaces"],
            path: "Sources"),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]),
    ]
)
