import Foundation
import Testing
@testable import LolayInvestigo

@Suite("LolayCrashlyticsTracker")
struct LolayCrashlyticsTrackerTests {
    enum TestError: Error {
        case test
    }

    @Test func defaultNamingIsSnakeCase() {
        let tracker = LolayCrashlyticsTracker()
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "search_performed")
    }

    @Test func customDotNotationNaming() {
        let tracker = LolayCrashlyticsTracker(naming: LolayDotNotationNaming())
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "Search.performed")
    }

    @Test func globalScopePrefixesEventName() {
        let tracker = LolayCrashlyticsTracker(globalScope: "App")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "app_search_performed")
    }

    @Test func properties() {
        let tracker = LolayCrashlyticsTracker()
        tracker.setIdentifier("1")
        tracker.setEmail("noreply@lolay.com")
        tracker.setName("Some Name")
        tracker.setGlobalParameter("1", forKey: "A")
        tracker.setGlobalParameters(["B": "2", "C": "3"])
        tracker.removeGlobalParameterForKey("A")
    }

    @Test func flatEvents() {
        let tracker = LolayCrashlyticsTracker()
        tracker.logEvent("Name Only")
        tracker.logEvent("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func pages() {
        let tracker = LolayCrashlyticsTracker()
        tracker.logPage("Name Only")
        tracker.logPage("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func errors() {
        let tracker = LolayCrashlyticsTracker()
        tracker.logError(TestError.test)
        tracker.logError(NSError(domain: "NSError", code: 0))
    }

    @Test func structuredEvents() {
        let tracker = LolayCrashlyticsTracker()
        tracker.logEvent(scope: "Search", action: "performed")
        tracker.logEvent(scope: "Search", action: "performed", parameters: ["type": "keyword"])
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: ["type": "keyword"], numericValue: 42)
    }
}
