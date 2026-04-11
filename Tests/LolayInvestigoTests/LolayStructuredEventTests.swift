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

@Suite("LolayMultipleTracker structured delegation")
struct LolayMultipleTrackerStructuredTests {
    @Test func delegatesStructuredEventsToChildren() {
        let child1 = RecordingTracker(naming: LolayDotNotationNaming(), globalScope: "App")
        let child2 = RecordingTracker(naming: LolaySnakeCaseNaming())
        let multi = LolayMultipleTracker(child1, child2)

        multi.logEvent(scope: "Lifecycle", action: "launched")

        #expect(child1.events.count == 1)
        #expect(child1.events[0].name == "App.Lifecycle.launched")
        #expect(child2.events.count == 1)
        #expect(child2.events[0].name == "lifecycle_launched")
    }

    @Test func delegatesStructuredEventsWithParameters() {
        let child = RecordingTracker(naming: LolayDotNotationNaming(), globalScope: "App")
        let multi = LolayMultipleTracker(child)

        multi.logEvent(scope: "Search", action: "performed",
                       parameters: ["source": "search", "type": "keyword"])

        #expect(child.events.count == 1)
        #expect(child.events[0].parameters == ["source": "search", "type": "keyword"])
    }

    @Test func delegatesStructuredEventsWithNumericValue() {
        let child = RecordingTracker(naming: LolayDotNotationNaming())
        let multi = LolayMultipleTracker(child)

        multi.logEvent(scope: "Index", action: "snapshot",
                       parameters: ["contentType": "public.png"],
                       numericValue: 100)

        #expect(child.events[0].numericValue == 100)
    }
}
