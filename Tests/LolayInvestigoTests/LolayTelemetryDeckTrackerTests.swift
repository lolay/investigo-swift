import Foundation
import Testing
@testable import LolayInvestigo

@Suite("LolayTelemetryDeckTracker")
struct LolayTelemetryDeckTrackerTests {
    static let dummyAppID = "00000000-0000-0000-0000-000000000000"

    @Test func defaultNamingIsDotNotation() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID, globalScope: "App")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "App.Search.performed")
    }

    @Test func customSnakeCaseNaming() {
        let tracker = LolayTelemetryDeckTracker(
            appID: Self.dummyAppID,
            naming: LolaySnakeCaseNaming(),
            globalScope: "App"
        )
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "app_search_performed")
    }

    @Test func withoutGlobalScope() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        let name = tracker.resolveEventName(scope: "Lifecycle", action: "launched")
        #expect(name == "Lifecycle.launched")
    }

    @Test func multiLevelScope() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID, globalScope: "App")
        let name = tracker.resolveEventName(scope: ["Search", "Result"], action: "opened")
        #expect(name == "App.Search.Result.opened")
    }

    @Test func properties() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.setIdentifier("user-123")
        tracker.setEmail("noreply@lolay.com")
        tracker.setName("Some Name")
        tracker.setVersion("1.0")
        tracker.setGlobalParameter("1", forKey: "A")
        tracker.setGlobalParameters(["B": "2", "C": "3"])
        tracker.removeGlobalParameterForKey("A")
    }

    @Test func flatEvents() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.logEvent("Name Only")
        tracker.logEvent("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func pages() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.logPage("Name Only")
        tracker.logPage("With Dictionary", withDictionary: ["A": "1"])
    }

    @Test func errors() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.logError(TestError.test)
        tracker.logError(NSError(domain: "TestDomain", code: 42))
        tracker.logException(NSException(name: .genericException, reason: "test reason"))
    }

    @Test func structuredEvents() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.logEvent(scope: "Lifecycle", action: "launched")
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: ["source": "search", "type": "keyword"])
        tracker.logEvent(scope: ["Search", "Result"], action: "opened",
                         parameters: ["contentType": "public.pdf"],
                         numericValue: nil)
    }

    @Test func structuredEventWithNumericValue() {
        let tracker = LolayTelemetryDeckTracker(appID: Self.dummyAppID)
        tracker.logEvent(scope: "Index", action: "snapshot",
                         parameters: ["contentType": "public.png"],
                         numericValue: 47418)
    }
}

private enum TestError: Error {
    case test
}
