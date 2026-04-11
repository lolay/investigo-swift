// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Copyright © 2026 Lolay, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import PackageDescription

let package = Package(
    name: "LolayInvestigo",
    platforms: [
        .iOS(.v18),
        .watchOS(.v11),
        .tvOS(.v18),
        .visionOS(.v2),
        .macCatalyst(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "LolayInvestigo",
            targets: ["LolayInvestigo"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            .upToNextMajor(from: "12.0.0")
        ),
        .package(
            url: "https://github.com/TelemetryDeck/SwiftSDK.git",
            .upToNextMajor(from: "2.0.0")
        )
    ],
    targets: [
        .target(
            name: "LolayInvestigo",
            dependencies: [
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk"),
                .product(name: "TelemetryDeck", package: "SwiftSDK")
            ]
        ),
        .testTarget(
            name: "LolayInvestigoTests",
            dependencies: ["LolayInvestigo"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
