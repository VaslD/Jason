// swift-tools-version:5.4
// This package requires at least Xcode 12.5

import PackageDescription

let package = Package(
    name: "Jason",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v11),
        .watchOS(.v4),
    ],
    products: [
        // Enables "JSON" typealias for Jason.
        .library(name: "JSON", targets: ["JSON"]),

        // Standard Jason module.
        .library(name: "Jason", targets: ["Jason"]),
    ],
    dependencies: [
        // .package(name: "ZippyJSON", url: "https://github.com/michaeleisel/ZippyJSON.git", from: "1.2.4")
    ],
    targets: [
        .target(name: "Jason"),
        .target(name: "JSON", dependencies: ["Jason"]),

        // Unit Tests
        .testTarget(name: "JasonTests", dependencies: [
            "Jason",
            // "ZippyJSON",
        ], exclude: [
            "Bundle+Module.swift",
        ], resources: [
            .process("Resources/"),
        ]),
    ]
)
