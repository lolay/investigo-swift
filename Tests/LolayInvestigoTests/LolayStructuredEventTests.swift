import Testing
@testable import LolayInvestigo

@Suite("Structured event recording via RecordingTracker")
struct LolayStructuredEventTests {
    @Test func structuredEventWithDotNaming() {
        let tracker = RecordingTracker(naming: LolayDotNotationNaming(), globalScope: "App")
        tracker.logEvent(scope: "Search", action: "performed")

        #expect(tracker.events.count == 1)
        #expect(tracker.events[0].name == "App.Search.performed")
    }

    @Test func structuredEventWithParameters() {
        let tracker = RecordingTracker(naming: LolayDotNotationNaming(), globalScope: "App")
        tracker.logEvent(scope: "Search", action: "performed", parameters: ["type": "keyword"])

        #expect(tracker.events.count == 1)
        #expect(tracker.events[0].name == "App.Search.performed")
        #expect(tracker.events[0].parameters == ["type": "keyword"])
    }

    @Test func structuredEventWithNumericValue() {
        let tracker = RecordingTracker(naming: LolayDotNotationNaming(), globalScope: "App")
        tracker.logEvent(scope: "Index", action: "snapshot",
                         parameters: ["contentType": "public.png"],
                         numericValue: 47418)

        #expect(tracker.events.count == 1)
        #expect(tracker.events[0].name == "App.Index.snapshot")
        #expect(tracker.events[0].parameters == ["contentType": "public.png"])
        #expect(tracker.events[0].numericValue == 47418)
    }

    @Test func structuredEventWithNilNumericValue() {
        let tracker = RecordingTracker(naming: LolayDotNotationNaming())
        tracker.logEvent(scope: "Search", action: "performed",
                         parameters: [:], numericValue: nil)

        #expect(tracker.events.count == 1)
        #expect(tracker.events[0].numericValue == nil)
    }

    @Test func structuredEventWithSnakeCaseNaming() {
        let tracker = RecordingTracker(naming: LolaySnakeCaseNaming())
        tracker.logEvent(scope: "Search", action: "performed")

        #expect(tracker.events[0].name == "search_performed")
    }

    @Test func multiLevelScopeEvent() {
        let tracker = RecordingTracker(naming: LolayDotNotationNaming(), globalScope: "App")
        tracker.logEvent(scope: ["Search", "Result"], action: "opened")

        #expect(tracker.events[0].name == "App.Search.Result.opened")
    }

    @Test func flatStringAPIStillWorks() {
        let tracker = RecordingTracker(naming: LolayDotNotationNaming())
        tracker.logEvent("App.launched")
        tracker.logEvent("Search.performed", withDictionary: ["type": "keyword"])

        #expect(tracker.events.count == 2)
        #expect(tracker.events[0].name == "App.launched")
        #expect(tracker.events[1].name == "Search.performed")
        #expect(tracker.events[1].parameters == ["type": "keyword"])
    }
}
