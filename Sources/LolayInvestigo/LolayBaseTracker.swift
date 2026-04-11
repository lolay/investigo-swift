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

open class LolayBaseTracker: LolayTracker {
    public let naming: LolayTrackerNamingStrategy
    public var globalScope: LolayTrackerScope?

    public init(naming: LolayTrackerNamingStrategy = LolayDotNotationNaming(),
                globalScope: LolayTrackerScope? = nil) {
        self.naming = naming
        self.globalScope = globalScope
    }

    // MARK: - Identity & global parameters (no-ops)

    open func setIdentifier(_ identifier: String) {}
    open func setVersion(_ version: String) {}
    open func setEmail(_ email: String) {}
    open func setName(_ name: String) {}
    open func setGlobalParameters(_ globalParameters: [String: String]) {}
    open func setGlobalParameter(_ value: String, forKey key: String) {}
    open func removeGlobalParameterForKey(_ key: String) {}

    // MARK: - Flat string event API (no-ops)

    open func logEvent(_ name: String) {}
    open func logEvent(_ name: String, withDictionary dictionary: [String: String]) {}

    // MARK: - Deprecated (no-ops)

    @available(*, deprecated, message: "Use logEvent(scope:action:) with a screen scope instead")
    open func logPage(_ name: String) {}
    @available(*, deprecated, message: "Use logEvent(scope:action:parameters:) with a screen scope instead")
    open func logPage(_ name: String, withDictionary dictionary: [String: String]) {}

    // MARK: - Error logging (no-ops)

    open func logError(_ error: Error) {}
    open func logError(_ error: NSError) {}
    open func logException(_ exception: NSException) {}

    // MARK: - Structured scope + action API (no-ops)

    open func logEvent(scope: LolayTrackerScope, action: String) {}
    open func logEvent(scope: LolayTrackerScope, action: String,
                       parameters: [String: String]) {}
    open func logEvent(scope: LolayTrackerScope, action: String,
                       parameters: [String: String], numericValue: Double?) {}

    // MARK: - Helpers

    /// Prepends globalScope (if set) to the given scope, then formats via the naming strategy.
    public func resolveEventName(scope: LolayTrackerScope, action: String) -> String {
        let fullScope: LolayTrackerScope
        if let global = globalScope {
            fullScope = LolayTrackerScope(global.components + scope.components)
        } else {
            fullScope = scope
        }
        return naming.formatEventName(scope: fullScope, action: action)
    }
}
