// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftWebP",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
    ],
    products: [
        .library(name: "SwiftWebP", targets: ["SwiftWebP"]),
    ],
    dependencies: [
        .package(url: "https://github.com/gewill/webp-spm.git", from: "1.6.1"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.58.0"),
    ],
    targets: [
        .target(
            name: "SwiftWebP",
            dependencies: [
                .product(name: "WebP", package: "webp-spm"),
                .product(name: "SharpYuv", package: "webp-spm")
            ],
            exclude: ["Info.plist"]
        ),
        .testTarget(
            name: "SwiftWebPTests",
            dependencies: ["SwiftWebP"],
            resources: [
                .copy("Resources/jiro.jpg")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
