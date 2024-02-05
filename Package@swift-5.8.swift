// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Blade",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v7),
    ],
    products: [
        .library(name: "Blade", targets: ["Blade"]),
        .library(name: "BladeTCA", targets: ["BladeTCA"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.5.5")),
    ],
    targets: [
        .target(name: "Blade"),
        .target(
            name: "BladeTCA",
            dependencies: [
                "Blade",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(name: "BladeTests", dependencies: ["Blade"]),
    ]
)
