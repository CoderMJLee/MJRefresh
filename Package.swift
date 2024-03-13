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
            exclude: ["Info.plist"],
            resources: [.process("MJRefresh.bundle"), .copy("PrivacyInfo.xcprivacy")],
            publicHeadersPath: "include",
            cSettings: [
                //Config header path
                .headerSearchPath("."),
            ]
        ),
    ]
)
