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

import Foundation
import Testing
@testable import LolayInvestigo

@Suite("LolayTelemetryDeckTracker")
struct LolayTelemetryDeckTrackerTests {
    static let dummyAppID = "00000000-0000-0000-0000-000000000000"

    @Test func defaultNamingIsDotNotation() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID, globalScope: "App")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "App.Search.performed")
    }

    @Test func customSnakeCaseNaming() {
        let tracker = LolayTelemetryDeckTracker(
            appID: Self.dummyAppID,
            naming: LolaySnakeCaseNaming(),
            globalScope: "App"
        )
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "app_search_performed")
    }

    @Test func withoutGlobalScope() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        let name = tracker.resolveEventName(scope: "Lifecycle", action: "launched")
        #expect(name == "Lifecycle.launched")
    }

    @Test func multiLevelScope() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID, globalScope: "App")
        let name = tracker.resolveEventName(scope: ["Search", "Result"], action: "opened")
        #expect(name == "App.Search.Result.opened")
    }

    @Test func properties() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.setIdentifier("user-123")
        tracker.setEmail("noreply@lolay.com")
        tracker.setName("Some Name")
        tracker.setVersion("1.0")
        tracker.setGlobalParameter("1", forKey: "A")
        tracker.setGlobalParameters(["B": "2", "C": "3"])
        tracker.removeGlobalParameterForKey("A")
    }

    @Test func flatEvents() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.logEvent("Name Only")
        tracker.logEvent("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func pages() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.logPage("Name Only")
        tracker.logPage("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func errors() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.logError(TestError.test)
        tracker.logError(NSError(domain: "TestDomain", code: 42))
        tracker.logException(NSException(name: .genericException, reason: "test reason"))
    }

    @Test func structuredEvents() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.logEvent(scope: "Lifecycle", action: "launched")
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: ["source": "search", "type": "keyword"])
        tracker.logEvent(scope: ["Search", "Result"], action: "opened",
                         parameters: ["contentType": "public.pdf"],
                         numericValue: nil)
    }

    @Test func structuredEventWithNumericValue() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.logEvent(scope: "Index", action: "snapshot",
                         parameters: ["contentType": "public.png"],
                         numericValue: 47418)
    }
}

private enum TestError: Error {
    case test
}
