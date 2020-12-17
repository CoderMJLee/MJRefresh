// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MJRefresh",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MJRefresh",
            targets: ["MJRefresh"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MJRefresh",
            dependencies: [],
            path: "MJRefresh",
            resources: [.process("MJRefresh.bundle")],
            cSettings: [.define("IF_MJ_SPM"),
                        .headerSearchPath("."),
                        .headerSearchPath("Base"),
                        .headerSearchPath("Custom")]),
        .testTarget(
            name: "MJRefreshTests",
            dependencies: ["MJRefresh"]),
    ]
)
