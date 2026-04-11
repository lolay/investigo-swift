//
//  Copyright © 2020, 2023, 2026 Lolay, Inc.
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

import Foundation
import Testing
@testable import LolayInvestigo

@Suite("LolayOSLogTracker")
struct LolayOSLogTrackerTests {
    enum TestError: Error {
        case test
    }

    @Test func defaultNamingIsDotNotation() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "Search.performed")
    }

    @Test func customSnakeCaseNaming() {
        let tracker = LolayOSLogTracker(
            bundleIdentifier: "com.lolay.test",
            naming: LolaySnakeCaseNaming()
        )
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "search_performed")
    }

    @Test func globalScopePrefixesEventName() {
        let tracker = LolayOSLogTracker(
            bundleIdentifier: "com.lolay.test",
            globalScope: "App"
        )
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "App.Search.performed")
    }

    @Test func flatEvents() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        tracker.logEvent("Name Only")
        tracker.logEvent("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func pages() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        tracker.logPage("Name Only")
        tracker.logPage("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func errors() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        tracker.logError(TestError.test)
        tracker.logError(NSError(domain: "TestDomain", code: 0))
    }

    @Test func structuredEvents() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        tracker.logEvent(scope: "Search", action: "performed")
        tracker.logEvent(scope: "Search", action: "performed", parameters: ["type": "keyword"])
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: ["type": "keyword"], numericValue: 42)
    }

    @Test func structuredEventWithNilNumericValue() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: [:], numericValue: nil)
    }
}
