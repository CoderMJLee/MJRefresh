// swift-tools-version:5.2
import PackageDescription

let package = Package(
  name: "MJRefresh",
  platforms: [
    .iOS(.v8),
  ],
  products: [
    .library(name: "MJRefresh", targets: ["MJRefresh"]),
  ],
  targets: [
    .target(name: "MJRefresh", path: ".", sources: ["MJRefresh"], publicHeadersPath: "MJRefresh"),
  ],
  swiftLanguageVersions: [.v5]
)
