// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.26.2")),
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
        .testTarget(
            name: "BladeTCATests",
            dependencies: [
                "BladeTCA",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
