// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MJRefresh",
    products: [
        .library(name: "MJRefresh", targets: ["MJRefresh"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MJRefresh",
            dependencies: [],
            path: "MJRefresh",
            resources: [.process("MJRefresh.bundle")],
            publicHeadersPath: "include",
            cSettings: [
                //Define macro "MJ_SPM" to identify whether Cocoapods or SPM are being used
                .define("MJ_SPM"),
                //Config header path
                .headerSearchPath("."),
                .headerSearchPath("Base"),
                .headerSearchPath("Custom/Footer/Auto"),
                .headerSearchPath("Custom/Footer/Back"),
                .headerSearchPath("Custom/Header"),
                .headerSearchPath("Custom/Trailer"),
            ]
        ),
    ]
)
