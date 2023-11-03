// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SWUtil",
    platforms: [
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
        .macOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SWUtil",
            targets: ["SWUtil"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "7.1.0"),
        .package(url:  "https://github.com/Quick/Nimble.git", from: "12.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SWUtil",
            dependencies: []),
        .testTarget(
            name: "SWUtilTests",
            dependencies: [
                "SWUtil",
                "Quick",
                "Nimble",
            ]),
    ]
)
