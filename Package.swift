// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "MJRefresh",
  platforms: [
    .iOS(.v9),
  ],
  products: [
    .library(name: "MJRefresh", targets: ["MJRefresh"]),
  ],
  targets: [
    .target(
      name: "MJRefresh",
      path: ".",
      exclude: [
        "Gif",
        "MJRefreshExample",
        "MJRefreshExampleTests",
        "MJRefreshFramework",
        "LICENSE",
        "MJRefresh.podspec",
        "README.md",
      ],
      sources: ["MJRefresh"],
      publicHeadersPath: "MJRefresh"
    ),
  ]
)
