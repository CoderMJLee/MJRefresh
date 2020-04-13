// swift-tools-version5.0
import PackageDescription

let package = Package(
    name: "MJRefresh",
    products: [
        .library(name: "MJRefresh", targets: ["MJRefresh"])
    ],
    targets: [
        .target(
            name: "MJRefresh",
            path: "MJRefresh"
        )
    ]
)
