import Foundation
@testable import LolayInvestigo

struct RecordedEvent {
    let name: String
    let parameters: [String: String]
    let numericValue: Double?
}

class RecordingTracker: LolayBaseTracker {
    var events: [RecordedEvent] = []
    var pages: [RecordedEvent] = []
    var errors: [String] = []
    var identifiers: [String] = []
    var globalParams: [String: String] = [:]

    override func setIdentifier(_ identifier: String) {
        identifiers.append(identifier)
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
        errors.append(error.localizedDescription)
    }

    override func logError(_ error: NSError) {
        errors.append(error.localizedDescription)
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
