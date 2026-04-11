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

import FirebaseAnalytics

public class LolayFirebaseTracker: LolayBaseTracker {
    override public init(naming: LolayTrackerNamingStrategy = LolaySnakeCaseNaming(),
                         globalScope: LolayTrackerScope? = nil) {
        super.init(naming: naming, globalScope: globalScope)
    }

    // MARK: - Identity & global parameters

    override public func setIdentifier(_ identifier: String) {
        Analytics.setUserID(identifier)
    }

    override public func setGlobalParameters(_ globalParameters: [String: String]) {
        for (key, value) in globalParameters {
            Analytics.setUserProperty(value, forName: key)
        }
    }

    override public func setGlobalParameter(_ value: String, forKey key: String) {
        Analytics.setUserProperty(value, forName: key)
    }

    override public func removeGlobalParameterForKey(_ key: String) {
        Analytics.setUserProperty(nil, forName: key)
    }

    // MARK: - Flat string event API

    override public func logEvent(_ name: String) {
        Analytics.logEvent(name, parameters: nil)
    }

    override public func logEvent(_ name: String, withDictionary dictionary: [String: String]) {
        Analytics.logEvent(name, parameters: dictionary)
    }

    // MARK: - Deprecated

    @available(*, deprecated, message: "Use logEvent(scope:action:) with a screen scope instead")
    override public func logPage(_ name: String) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [AnalyticsParameterScreenName: name + "_page"])
    }

    @available(*, deprecated, message: "Use logEvent(scope:action:parameters:) with a screen scope instead")
    override public func logPage(_ name: String, withDictionary dictionary: [String: String]) {
        let parameters = dictionary.merging([AnalyticsParameterScreenName: name + "_page"]) { _, new in new }
        Analytics.logEvent(AnalyticsEventScreenView, parameters: parameters)
    }

    // MARK: - Structured scope + action API

    override public func logEvent(scope: LolayTrackerScope, action: String) {
        let name = resolveEventName(scope: scope, action: action)
        Analytics.logEvent(name, parameters: nil)
    }

    override public func logEvent(scope: LolayTrackerScope, action: String,
                                  parameters: [String: String]) {
        let name = resolveEventName(scope: scope, action: action)
        Analytics.logEvent(name, parameters: parameters)
    }

    override public func logEvent(scope: LolayTrackerScope, action: String,
                                  parameters: [String: String], numericValue: Double?) {
        let name = resolveEventName(scope: scope, action: action)
        if let numericValue {
            let merged = parameters.merging([AnalyticsParameterValue: String(numericValue)]) { existing, _ in existing }
            Analytics.logEvent(name, parameters: merged)
        } else {
            Analytics.logEvent(name, parameters: parameters)
        }
    }
}
