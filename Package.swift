// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FitCsv",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FitCsv",
            targets: ["FitCsv"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        //.package(url: "https://github.com/roznet/FitFileParser", .branch( "main" )),
        //.package(name: "RZUtils", url: "https://github.com/roznet/rzutils", from: "1.0.0"  ),
        .package(name: "FitFileParser", path: "../FitFileParser"),
        .package(name: "RZUtils", path: "../rzutils"),
        .package(name:"SwiftCSV", url: "https://github.com/swiftcsv/SwiftCSV", from: "0.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FitCsv",
            dependencies: [
                .product( name: "FitFileParser", package: "FitFileParser"),
                .product( name: "RZUtilsSwift", package: "RZUtils"),
                .product( name: "SwiftCSV", package: "SwiftCSV")
            ]
        ),
        .testTarget(
            name: "FitCsvTests",
            dependencies: ["FitCsv",
                           .product( name: "FitFileParser", package: "FitFileParser"),
                           .product( name: "RZUtilsSwift", package: "RZUtils")
            ],
            exclude: [ "samples" ]
        ),
        
    ]
)
