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

import Testing
@testable import LolayInvestigo

@Suite("LolayFirebaseTracker")
struct LolayFirebaseTrackerTests {
    @Test func defaultNamingIsSnakeCase() {
        let tracker = LolayFirebaseTracker()
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "search_performed")
    }

    @Test func customDotNotationNaming() {
        let tracker = LolayFirebaseTracker(naming: LolayDotNotationNaming())
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "Search.performed")
    }

    @Test func globalScopePrefixesEventName() {
        let tracker = LolayFirebaseTracker(globalScope: "App")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "app_search_performed")
    }

    @Test func properties() {
        let tracker = LolayFirebaseTracker()
        tracker.setIdentifier("1")
        tracker.setGlobalParameter("1", forKey: "A")
        tracker.setGlobalParameters(["B": "2", "C": "3"])
        tracker.removeGlobalParameterForKey("A")
    }

    @Test func flatEvents() {
        let tracker = LolayFirebaseTracker()
        tracker.logEvent("Name Only")
        tracker.logEvent("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func pages() {
        let tracker = LolayFirebaseTracker()
        tracker.logPage("Name Only")
        tracker.logPage("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func structuredEvents() {
        let tracker = LolayFirebaseTracker()
        tracker.logEvent(scope: "Search", action: "performed")
        tracker.logEvent(scope: "Search", action: "performed", parameters: ["type": "keyword"])
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: ["type": "keyword"], numericValue: 42)
    }
}
