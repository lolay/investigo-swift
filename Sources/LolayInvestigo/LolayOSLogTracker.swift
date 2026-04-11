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
import os.log

public class LolayOSLogTracker: LolayBaseTracker {
    public var log: OSLog

    public init(bundleIdentifier: String,
                naming: LolayTrackerNamingStrategy = LolayDotNotationNaming(),
                globalScope: LolayTrackerScope? = nil) {
        let className = String(describing: type(of: self))
        self.log = OSLog(subsystem: bundleIdentifier, category: className)
        super.init(naming: naming, globalScope: globalScope)
    }

    // MARK: - Flat string event API

    override public func logEvent(_ name: String) {
        os_log(.info, log: log, "event=%{PUBLIC}@", name)
    }

    override public func logEvent(_ name: String, withDictionary dictionary: [String: String]) {
        os_log(.info, log: log, "event=%{PUBLIC}@, dictionary=%{PUBLIC}@", name, dictionary.description)
    }

    // MARK: - Deprecated

    @available(*, deprecated, message: "Use logEvent(scope:action:) with a screen scope instead")
    override public func logPage(_ name: String) {
        os_log(.info, log: log, "page=%{PUBLIC}@", name)
    }

    @available(*, deprecated, message: "Use logEvent(scope:action:parameters:) with a screen scope instead")
    override public func logPage(_ name: String, withDictionary dictionary: [String: String]) {
        os_log(.info, log: log, "page=%{PUBLIC}@, dictionary=%{PUBLIC}@", name, dictionary.description)
    }

    // MARK: - Error logging

    override public func logError(_ error: Error) {
        os_log(.error, log: log, "error=%{PUBLIC}@", error.localizedDescription)
    }

    override public func logError(_ error: NSError) {
        os_log(.error, log: log, "error=%{PUBLIC}@", error.localizedDescription)
    }

    override public func logException(_ exception: NSException) {
        os_log(.fault, log: log, "exception=%{PUBLIC}@", exception.debugDescription)
    }

    // MARK: - Structured scope + action API

    override public func logEvent(scope: LolayTrackerScope, action: String) {
        let name = resolveEventName(scope: scope, action: action)
        os_log(.info, log: log, "event=%{PUBLIC}@", name)
    }

    override public func logEvent(scope: LolayTrackerScope, action: String,
                                  parameters: [String: String]) {
        let name = resolveEventName(scope: scope, action: action)
        os_log(.info, log: log, "event=%{PUBLIC}@, parameters=%{PUBLIC}@", name, parameters.description)
    }

    override public func logEvent(scope: LolayTrackerScope, action: String,
                                  parameters: [String: String], numericValue: Double?) {
        let name = resolveEventName(scope: scope, action: action)
        if let numericValue {
            os_log(.info, log: log, "event=%{PUBLIC}@, parameters=%{PUBLIC}@, numericValue=%{PUBLIC}f", name, parameters.description, numericValue)
        } else {
            os_log(.info, log: log, "event=%{PUBLIC}@, parameters=%{PUBLIC}@", name, parameters.description)
        }
    }
}
