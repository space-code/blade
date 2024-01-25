// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Blade",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v7),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "Blade", targets: ["Blade"]),
    ],
    targets: [
        .target(name: "Blade"),
        .testTarget(name: "BladeTests", dependencies: ["Blade"]),
    ]
)
