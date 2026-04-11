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
import TelemetryDeck

public class LolayTelemetryDeckTracker: LolayBaseTracker {
    private var storedGlobalParameters: [String: String] = [:]

    public init(appID: String,
                naming: LolayTrackerNamingStrategy = LolayDotNotationNaming(),
                globalScope: LolayTrackerScope? = nil) {
        super.init(naming: naming, globalScope: globalScope)
        let config = TelemetryDeck.Config(appID: appID)
        TelemetryDeck.initialize(config: config)
    }

    // MARK: - Identity

    override public func setIdentifier(_ identifier: String) {
        TelemetryDeck.updateDefaultUserID(to: identifier)
    }

    // MARK: - Global parameters

    override public func setGlobalParameters(_ globalParameters: [String: String]) {
        storedGlobalParameters = globalParameters
    }

    override public func setGlobalParameter(_ value: String, forKey key: String) {
        storedGlobalParameters[key] = value
    }

    override public func removeGlobalParameterForKey(_ key: String) {
        storedGlobalParameters.removeValue(forKey: key)
    }

    private func mergedParameters(_ parameters: [String: String] = [:]) -> [String: String] {
        storedGlobalParameters.merging(parameters) { _, perEvent in perEvent }
    }

    // MARK: - Flat string event API

    override public func logEvent(_ name: String) {
        TelemetryDeck.signal(name, parameters: mergedParameters())
    }

    override public func logEvent(_ name: String, withDictionary dictionary: [String: String]) {
        TelemetryDeck.signal(name, parameters: mergedParameters(dictionary))
    }

    // MARK: - Deprecated

    @available(*, deprecated, message: "Use logEvent(scope:action:) with a screen scope instead")
    override public func logPage(_ name: String) {
        TelemetryDeck.signal(name + ".page", parameters: mergedParameters())
    }

    @available(*, deprecated, message: "Use logEvent(scope:action:parameters:) with a screen scope instead")
    override public func logPage(_ name: String, withDictionary dictionary: [String: String]) {
        TelemetryDeck.signal(name + ".page", parameters: mergedParameters(dictionary))
    }

    // MARK: - Error logging

    override public func logError(_ error: Error) {
        TelemetryDeck.signal("error", parameters: mergedParameters([
            "errorDescription": error.localizedDescription
        ]))
    }

    override public func logError(_ error: NSError) {
        TelemetryDeck.signal("error", parameters: mergedParameters([
            "errorDomain": error.domain,
            "errorCode": String(error.code),
            "errorDescription": error.localizedDescription
        ]))
    }

    override public func logException(_ exception: NSException) {
        var params: [String: String] = ["exceptionName": exception.name.rawValue]
        if let reason = exception.reason {
            params["exceptionReason"] = reason
        }
        TelemetryDeck.signal("exception", parameters: mergedParameters(params))
    }

    // MARK: - Structured scope + action API

    override public func logEvent(scope: LolayTrackerScope, action: String) {
        let name = resolveEventName(scope: scope, action: action)
        TelemetryDeck.signal(name, parameters: mergedParameters())
    }

    override public func logEvent(scope: LolayTrackerScope, action: String,
                                  parameters: [String: String]) {
        let name = resolveEventName(scope: scope, action: action)
        TelemetryDeck.signal(name, parameters: mergedParameters(parameters))
    }

    override public func logEvent(scope: LolayTrackerScope, action: String,
                                  parameters: [String: String], numericValue: Double?) {
        let name = resolveEventName(scope: scope, action: action)
        if let numericValue {
            TelemetryDeck.signal(name, parameters: mergedParameters(parameters), floatValue: numericValue)
        } else {
            TelemetryDeck.signal(name, parameters: mergedParameters(parameters))
        }
    }
}
