// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Interfaces",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Interfaces",
            targets: ["Interfaces"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Interfaces",
            dependencies: []),
        .testTarget(
            name: "InterfacesTests",
            dependencies: ["Interfaces"]),
    ]
)
