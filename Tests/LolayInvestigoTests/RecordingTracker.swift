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
@testable import LolayInvestigo

struct RecordedEvent: Equatable {
    let name: String
    let parameters: [String: String]
    let numericValue: Double?
}

struct RecordedError: Equatable {
    let description: String
    let domain: String?
    let code: Int?
}

class RecordingTracker: LolayBaseTracker {
    var events: [RecordedEvent] = []
    var pages: [RecordedEvent] = []
    var errors: [RecordedError] = []
    var exceptions: [String] = []
    var identifiers: [String] = []
    var versions: [String] = []
    var emails: [String] = []
    var names: [String] = []
    var globalParams: [String: String] = [:]

    override func setIdentifier(_ identifier: String) {
        identifiers.append(identifier)
    }

    override func setVersion(_ version: String) {
        versions.append(version)
    }

    override func setEmail(_ email: String) {
        emails.append(email)
    }

    override func setName(_ name: String) {
        names.append(name)
    }

    override func setGlobalParameters(_ globalParameters: [String: String]) {
        globalParams = globalParameters
    }

    override func setGlobalParameter(_ value: String, forKey key: String) {
        globalParams[key] = value
    }

    override func removeGlobalParameterForKey(_ key: String) {
        globalParams.removeValue(forKey: key)
    }

    override func logEvent(_ name: String) {
        events.append(RecordedEvent(name: name, parameters: [:], numericValue: nil))
    }

    override func logEvent(_ name: String, withDictionary dictionary: [String: String]) {
        events.append(RecordedEvent(name: name, parameters: dictionary, numericValue: nil))
    }

    override func logPage(_ name: String) {
        pages.append(RecordedEvent(name: name, parameters: [:], numericValue: nil))
    }

    override func logPage(_ name: String, withDictionary dictionary: [String: String]) {
        pages.append(RecordedEvent(name: name, parameters: dictionary, numericValue: nil))
    }

    override func logError(_ error: Error) {
        errors.append(RecordedError(description: error.localizedDescription, domain: nil, code: nil))
    }

    override func logError(_ error: NSError) {
        errors.append(RecordedError(description: error.localizedDescription, domain: error.domain, code: error.code))
    }

    override func logException(_ exception: NSException) {
        exceptions.append(exception.name.rawValue)
    }

    override func logEvent(scope: LolayTrackerScope, action: String) {
        let name = resolveEventName(scope: scope, action: action)
        events.append(RecordedEvent(name: name, parameters: [:], numericValue: nil))
    }

    override func logEvent(scope: LolayTrackerScope, action: String, parameters: [String: String]) {
        let name = resolveEventName(scope: scope, action: action)
        events.append(RecordedEvent(name: name, parameters: parameters, numericValue: nil))
    }

    override func logEvent(scope: LolayTrackerScope, action: String, parameters: [String: String], numericValue: Double?) {
        let name = resolveEventName(scope: scope, action: action)
        events.append(RecordedEvent(name: name, parameters: parameters, numericValue: numericValue))
    }
}
