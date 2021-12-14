// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Experiments",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Experiments",
            targets: ["Experiments"]),
    ],
    dependencies: [
        .package(url: "Interfaces", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Experiments",
            dependencies: ["Interfaces"],
            path: "Sources"),
        .testTarget(
            name: "ExperimentsTests",
            dependencies: ["Experiments"]),
    ]
)
