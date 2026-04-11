import Testing
@testable import LolayInvestigo

@Suite("LolayFirebaseTracker")
struct LolayFirebaseTrackerTests {
    @Test func defaultNamingIsSnakeCase() {
        let tracker = LolayFirebaseTracker()
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "search_performed")
    }

    @Test func customDotNotationNaming() {
        let tracker = LolayFirebaseTracker(naming: LolayDotNotationNaming())
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "Search.performed")
    }

    @Test func globalScopePrefixesEventName() {
        let tracker = LolayFirebaseTracker(globalScope: "App")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "app_search_performed")
    }

    @Test func properties() {
        let tracker = LolayFirebaseTracker()
        tracker.setIdentifier("1")
        tracker.setGlobalParameter("1", forKey: "A")
        tracker.setGlobalParameters(["B": "2", "C": "3"])
        tracker.removeGlobalParameterForKey("A")
    }

    @Test func flatEvents() {
        let tracker = LolayFirebaseTracker()
        tracker.logEvent("Name Only")
        tracker.logEvent("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func pages() {
        let tracker = LolayFirebaseTracker()
        tracker.logPage("Name Only")
        tracker.logPage("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func structuredEvents() {
        let tracker = LolayFirebaseTracker()
        tracker.logEvent(scope: "Search", action: "performed")
        tracker.logEvent(scope: "Search", action: "performed", parameters: ["type": "keyword"])
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: ["type": "keyword"], numericValue: 42)
    }
}
