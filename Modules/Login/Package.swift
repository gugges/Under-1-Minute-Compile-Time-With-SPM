// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Login",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Login",
            targets: ["Login"]),
    ],
    dependencies: [
        .package(url: "Interfaces", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Login",
            dependencies: ["Interfaces"],
            path: "Sources",
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "LoginTests",
            dependencies: ["Login"]),
    ]
)
