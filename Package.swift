// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Sticker",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .visionOS(.v1),
        .watchOS(.v10)
    ],
    products: [
        .library(
            name: "Sticker",
            targets: ["Sticker"]
        ),
    ],
    targets: [
        .target(name: "Sticker"),
    ]
)
