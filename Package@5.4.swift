// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "Jason",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        // Enables "JSON" type-alias for Jason.
        .library(name: "JSON", targets: ["JSON"]),

        // Standard Jason module.
        .library(name: "Jason", targets: ["Jason"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Jason", exclude: [
            "Documentation.docc/",
        ]),
        .target(name: "JSON", dependencies: ["Jason"]),

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
