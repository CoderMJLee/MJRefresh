// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MJRefresh",
    platforms: [
        .iOS(.v8)
    ],
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
