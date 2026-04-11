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

import Testing
@testable import LolayInvestigo

@Suite("LolayBaseTracker.resolveEventName")
struct LolayBaseTrackerResolveTests {
    @Test func withoutGlobalScope() {
        let tracker = LolayBaseTracker(naming: LolayDotNotationNaming())
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "Search.performed")
    }

    @Test func withGlobalScope() {
        let tracker = LolayBaseTracker(naming: LolayDotNotationNaming(), globalScope: "App")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "App.Search.performed")
    }

    @Test func withMultiLevelGlobalScope() {
        let tracker = LolayBaseTracker(naming: LolayDotNotationNaming(), globalScope: ["Desk", "Hound"])
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "Desk.Hound.Search.performed")
    }

    @Test func snakeCaseWithGlobalScope() {
        let tracker = LolayBaseTracker(naming: LolaySnakeCaseNaming(), globalScope: "App")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "app_search_performed")
    }

    @Test func globalScopeSetAfterInit() {
        let tracker = LolayBaseTracker(naming: LolayDotNotationNaming())
        #expect(tracker.resolveEventName(scope: "Search", action: "performed") == "Search.performed")

        tracker.globalScope = "App"
        #expect(tracker.resolveEventName(scope: "Search", action: "performed") == "App.Search.performed")
    }
}
