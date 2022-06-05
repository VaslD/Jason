// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Jason",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
        .macCatalyst(.v13),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        // Standard Jason module.
        .library(name: "Jason", targets: ["Jason"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Jason"),

        // Unit Tests
        .testTarget(name: "JasonTests", dependencies: [
            "Jason",
        ], exclude: [
            "Bundle+Module.swift",
        ], resources: [
            .process("Resources/"),
        ]),
    ]
)
