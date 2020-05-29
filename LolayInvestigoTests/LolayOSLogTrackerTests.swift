//
//  Copyright © 2020 Lolay, Inc.
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

import XCTest
@testable import LolayInvestigo

class LolayOSLogTrackerTests: XCTestCase {
    var tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.LolayInvestigo")
    
    enum TestError: Error {
        case test
    }
    
    func testEvents() {
        tracker.logEvent("Name Only")
        tracker.logEvent("With Dictionary", withDictionary: ["A": "1"])
    }

    func testPages() {
        tracker.logPage("Name Only")
        tracker.logPage("With Dictionary", withDictionary: ["A": "1"])
    }
    
    func testErrors() {
        tracker.logError(TestError.test)
        tracker.logError(NSError(domain: "NSError", code: 0))
    }
}
