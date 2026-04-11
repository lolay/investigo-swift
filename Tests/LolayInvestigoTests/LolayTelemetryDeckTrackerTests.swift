import XCTest
@testable import LolayInvestigo

class LolayTelemetryDeckTrackerTests: XCTestCase {
    var tracker = LolayTelemetryDeckTracker(appID: "00000000-0000-0000-0000-000000000000", globalScope: "App")

    enum TestError: Error {
        case test
    }

    func testProperties() {
        tracker.setIdentifier("user-123")
        tracker.setEmail("noreply@lolay.com")
        tracker.setName("Some Name")
        tracker.setVersion("1.0")
        tracker.setGlobalParameter("1", forKey: "A")
        tracker.setGlobalParameters(["B": "2", "C": "3"])
        tracker.removeGlobalParameterForKey("A")
    }

    func testFlatEvents() {
        tracker.logEvent("Name Only")
        tracker.logEvent("With Dictionary", withDictionary: ["A": "1"])
    }

    func testPages() {
        tracker.logPage("Name Only")
        tracker.logPage("With Dictionary", withDictionary: ["A": "1"])
    }

    func testErrors() {
        tracker.logError(TestError.test)
        tracker.logError(NSError(domain: "TestDomain", code: 42))
        tracker.logException(NSException(name: .genericException, reason: "test reason"))
    }

    func testStructuredEvents() {
        tracker.logEvent(scope: "Lifecycle", action: "launched")
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: ["source": "search", "type": "keyword"])
        tracker.logEvent(scope: ["Search", "Result"], action: "opened",
                         parameters: ["contentType": "public.pdf"],
                         numericValue: nil)
    }

    func testStructuredEventWithNumericValue() {
        tracker.logEvent(scope: "Index", action: "snapshot",
                         parameters: ["parentContentType": "public.image",
                                      "contentType": "public.png",
                                      "sizeBucket": "small"],
                         numericValue: 47418)
    }

    func testDefaultNamingIsDotNotation() {
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        XCTAssertEqual(name, "App.Search.performed")
    }

    func testCustomNamingStrategy() {
        let snakeTracker = LolayTelemetryDeckTracker(
            appID: "00000000-0000-0000-0000-000000000000",
            naming: LolaySnakeCaseNaming(),
            globalScope: "App"
        )
        let name = snakeTracker.resolveEventName(scope: "Search", action: "performed")
        XCTAssertEqual(name, "app_search_performed")
    }
}
