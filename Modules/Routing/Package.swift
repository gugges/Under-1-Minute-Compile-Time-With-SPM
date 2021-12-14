// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Routing",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Routing",
            targets: ["Routing"]),
    ],
    dependencies: [
        .package(url: "Interfaces", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Routing",
            dependencies: ["Interfaces"],
            path: "Sources"),
        .testTarget(
            name: "RoutingTests",
            dependencies: ["Routing"]),
    ]
)
