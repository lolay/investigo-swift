import Testing
@testable import LolayInvestigo

@Suite("LolayDotNotationNaming")
struct LolayDotNotationNamingTests {
    let naming = LolayDotNotationNaming()

    @Test func singleScope() {
        let result = naming.formatEventName(scope: "Search", action: "performed")
        #expect(result == "Search.performed")
    }

    @Test func multiLevelScope() {
        let result = naming.formatEventName(scope: ["Search", "Result"], action: "opened")
        #expect(result == "Search.Result.opened")
    }

    @Test func threeLevelScope() {
        let result = naming.formatEventName(scope: ["App", "Search", "Result"], action: "opened")
        #expect(result == "App.Search.Result.opened")
    }

    @Test func preservesCasing() {
        let result = naming.formatEventName(scope: "Lifecycle", action: "launched")
        #expect(result == "Lifecycle.launched")
    }
}

@Suite("LolaySnakeCaseNaming")
struct LolaySnakeCaseNamingTests {
    let naming = LolaySnakeCaseNaming()

    @Test func singleScope() {
        let result = naming.formatEventName(scope: "Search", action: "performed")
        #expect(result == "search_performed")
    }

    @Test func multiLevelScope() {
        let result = naming.formatEventName(scope: ["Search", "Result"], action: "opened")
        #expect(result == "search_result_opened")
    }

    @Test func camelCaseToSnakeCase() {
        let result = naming.formatEventName(scope: "AppLifecycle", action: "launched")
        #expect(result == "app_lifecycle_launched")
    }

    @Test func alreadyLowercase() {
        let result = naming.formatEventName(scope: "search", action: "performed")
        #expect(result == "search_performed")
    }

    @Test func multiWordAction() {
        let result = naming.formatEventName(scope: "Settings", action: "valueChanged")
        #expect(result == "settings_value_changed")
    }
}
