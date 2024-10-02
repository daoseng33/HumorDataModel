// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HumorDataModel",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "HumorDataModel",
            targets: ["HumorDataModel"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "10.0.0")),
    ],
    targets: [
        .target(
            name: "HumorDataModel",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift")
            ]
        ),
        .testTarget(
            name: "HumorDataModelTests",
            dependencies: ["HumorDataModel"]
        ),
    ]
)
