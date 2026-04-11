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

public protocol LolayTracker {
    // MARK: - Identity & global parameters (existing)

    func setIdentifier(_ identifier: String)
    func setVersion(_ version: String)
    func setEmail(_ email: String)
    func setName(_ name: String)
    func setGlobalParameters(_ globalParameters: [String: String])
    func setGlobalParameter(_ value: String, forKey key: String)
    func removeGlobalParameterForKey(_ key: String)

    // MARK: - Flat string event API (existing)

    func logEvent(_ name: String)
    func logEvent(_ name: String, withDictionary dictionary: [String: String])

    // MARK: - Deprecated

    @available(*, deprecated, message: "Use logEvent(scope:action:) with a screen scope instead and action of -page")
    func logPage(_ name: String)
    @available(*, deprecated, message: "Use logEvent(scope:action:parameters:) with a screen scope instead and action of -page")
    func logPage(_ name: String, withDictionary dictionary: [String: String])

    // MARK: - Error logging (existing)

    func logError(_ error: Error)
    func logError(_ error: NSError)
    func logException(_ exception: NSException)

    // MARK: - Global scope (new in v6)

    var globalScope: LolayTrackerScope? { get set }

    // MARK: - Structured scope + action API (new in v6)

    func logEvent(scope: LolayTrackerScope, action: String)
    func logEvent(scope: LolayTrackerScope, action: String,
                  parameters: [String: String])
    func logEvent(scope: LolayTrackerScope, action: String,
                  parameters: [String: String], numericValue: Double?)
}
