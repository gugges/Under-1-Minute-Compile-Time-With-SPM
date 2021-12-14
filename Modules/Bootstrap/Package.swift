// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Bootstrap",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Bootstrap",
            targets: ["Bootstrap"]),
    ],
    dependencies: [
        .package(url: "Interfaces", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Bootstrap",
            dependencies: ["Interfaces"],
            path: "Sources"),
        .testTarget(
            name: "BootstrapTests",
            dependencies: ["Bootstrap"]),
    ]
)
