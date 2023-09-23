// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NoVaporAPI",
    platforms: [
       .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NoVaporAPI",
            targets: ["NoVaporAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.78.0"),
    ],
    targets: [
        .target(
            name: "NoVaporAPI",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ]),
        .testTarget(
            name: "NoVaporAPITests",
            dependencies: ["NoVaporAPI"]),
    ]
)
