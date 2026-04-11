import Foundation
import Testing
@testable import LolayInvestigo

@Suite("LolayOSLogTracker")
struct LolayOSLogTrackerTests {
    enum TestError: Error {
        case test
    }

    @Test func defaultNamingIsDotNotation() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "Search.performed")
    }

    @Test func customSnakeCaseNaming() {
        let tracker = LolayOSLogTracker(
            bundleIdentifier: "com.lolay.test",
            naming: LolaySnakeCaseNaming()
        )
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "search_performed")
    }

    @Test func globalScopePrefixesEventName() {
        let tracker = LolayOSLogTracker(
            bundleIdentifier: "com.lolay.test",
            globalScope: "App"
        )
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "App.Search.performed")
    }

    @Test func flatEvents() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        tracker.logEvent("Name Only")
        tracker.logEvent("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func pages() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        tracker.logPage("Name Only")
        tracker.logPage("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func errors() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        tracker.logError(TestError.test)
        tracker.logError(NSError(domain: "TestDomain", code: 0))
    }

    @Test func structuredEvents() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        tracker.logEvent(scope: "Search", action: "performed")
        tracker.logEvent(scope: "Search", action: "performed", parameters: ["type": "keyword"])
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: ["type": "keyword"], numericValue: 42)
    }

    @Test func structuredEventWithNilNumericValue() {
        let tracker = LolayOSLogTracker(bundleIdentifier: "com.lolay.test")
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: [:], numericValue: nil)
    }
}
