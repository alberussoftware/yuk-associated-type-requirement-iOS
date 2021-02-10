// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "YUKAssociatedTypeRequirement",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
  ],
  products: [
    .library(name: "YUKAssociatedTypeRequirement", targets: ["YUKAssociatedTypeRequirement"]),
  ],
  dependencies: [ ],
  targets: [
    .target(name: "CContext", path: "Sources/YUKAssociatedTypeRequirement/CContext"),
    .target(name: "YUKAssociatedTypeRequirement", dependencies: ["CContext"], exclude: ["CContext"]),
    .testTarget(name: "YUKAssociatedTypeRequirementTests", dependencies: ["YUKAssociatedTypeRequirement"]),
  ],
  cLanguageStandard: .gnu11
)
