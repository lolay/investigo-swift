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

@Suite("LolayDotNotationNaming")
struct LolayDotNotationNamingTests {
    let naming = LolayDotNotationNaming()

    @Test func singleScope() {
        let result = naming.formatEventName(scope: "Search", action: "performed")
        #expect(result == "Search.performed")
    }

    @Test func multiLevelScope() {
        let result = naming.formatEventName(scope: ["Search", "Result"], action: "opened")
        #expect(result == "Search.Result.opened")
    }

    @Test func threeLevelScope() {
        let result = naming.formatEventName(scope: ["App", "Search", "Result"], action: "opened")
        #expect(result == "App.Search.Result.opened")
    }

    @Test func preservesCasing() {
        let result = naming.formatEventName(scope: "Lifecycle", action: "launched")
        #expect(result == "Lifecycle.launched")
    }
}

@Suite("LolaySnakeCaseNaming")
struct LolaySnakeCaseNamingTests {
    let naming = LolaySnakeCaseNaming()

    @Test func singleScope() {
        let result = naming.formatEventName(scope: "Search", action: "performed")
        #expect(result == "search_performed")
    }

    @Test func multiLevelScope() {
        let result = naming.formatEventName(scope: ["Search", "Result"], action: "opened")
        #expect(result == "search_result_opened")
    }

    @Test func camelCaseToSnakeCase() {
        let result = naming.formatEventName(scope: "AppLifecycle", action: "launched")
        #expect(result == "app_lifecycle_launched")
    }

    @Test func alreadyLowercase() {
        let result = naming.formatEventName(scope: "search", action: "performed")
        #expect(result == "search_performed")
    }

    @Test func multiWordAction() {
        let result = naming.formatEventName(scope: "Settings", action: "valueChanged")
        #expect(result == "settings_value_changed")
    }
}
