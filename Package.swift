// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "dmtools",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "DMTools", targets: ["DMTools"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .branch("v9.0.0-rc.3"))
    ],
    targets: [
        .target(name: "DMTools", path: "DMTools"),
        .testTarget(name: "Tests", dependencies: [.target(name: "DMTools"), .byName(name: "Quick"), .byName(name: "Nimble")], path: "Tests"),
    ]    
)
