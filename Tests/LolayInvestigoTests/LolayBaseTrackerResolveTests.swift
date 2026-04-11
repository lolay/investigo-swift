import Testing
@testable import LolayInvestigo

@Suite("LolayBaseTracker.resolveEventName")
struct LolayBaseTrackerResolveTests {
    @Test func withoutGlobalScope() {
        let tracker = LolayBaseTracker(naming: LolayDotNotationNaming())
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "Search.performed")
    }

    @Test func withGlobalScope() {
        let tracker = LolayBaseTracker(naming: LolayDotNotationNaming(), globalScope: "App")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "App.Search.performed")
    }

    @Test func withMultiLevelGlobalScope() {
        let tracker = LolayBaseTracker(naming: LolayDotNotationNaming(), globalScope: ["Desk", "Hound"])
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "Desk.Hound.Search.performed")
    }

    @Test func snakeCaseWithGlobalScope() {
        let tracker = LolayBaseTracker(naming: LolaySnakeCaseNaming(), globalScope: "App")
        let name = tracker.resolveEventName(scope: "Search", action: "performed")
        #expect(name == "app_search_performed")
    }

    @Test func globalScopeSetAfterInit() {
        let tracker = LolayBaseTracker(naming: LolayDotNotationNaming())
        #expect(tracker.resolveEventName(scope: "Search", action: "performed") == "Search.performed")

        tracker.globalScope = "App"
        #expect(tracker.resolveEventName(scope: "Search", action: "performed") == "App.Search.performed")
    }
}
