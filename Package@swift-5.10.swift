// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let strictConcurrency: [SwiftSetting] = [.enableExperimentalFeature("StrictConcurrency")]

let package = Package(
    name: "Blade",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "Blade", targets: ["Blade"]),
        .library(name: "BladeTCA", targets: ["BladeTCA"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.5.5")),
    ],
    targets: [
        .target(name: "Blade", swiftSettings: strictConcurrency),
        .target(
            name: "BladeTCA",
            dependencies: [
                "Blade",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            swiftSettings: strictConcurrency
        ),
        .testTarget(name: "BladeTests", dependencies: ["Blade"], swiftSettings: strictConcurrency),
        .testTarget(
            name: "BladeTCATests",
            dependencies: [
                "BladeTCA",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            swiftSettings: strictConcurrency
        ),
    ],
    swiftLanguageVersions: [.v5]
)
