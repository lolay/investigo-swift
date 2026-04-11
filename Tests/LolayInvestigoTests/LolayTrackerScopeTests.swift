import Testing
@testable import LolayInvestigo

@Suite("LolayTrackerScope")
struct LolayTrackerScopeTests {
    @Test func stringLiteral() {
        let scope: LolayTrackerScope = "Search"
        #expect(scope.components == ["Search"])
    }

    @Test func arrayLiteral() {
        let scope: LolayTrackerScope = ["Search", "Result"]
        #expect(scope.components == ["Search", "Result"])
    }

    @Test func variadicInit() {
        let scope = LolayTrackerScope("App", "Search", "Result")
        #expect(scope.components == ["App", "Search", "Result"])
    }

    @Test func arrayInit() {
        let scope = LolayTrackerScope(["App", "Lifecycle"])
        #expect(scope.components == ["App", "Lifecycle"])
    }

    @Test func concatenation() {
        let global = LolayTrackerScope("App")
        let local: LolayTrackerScope = "Search"
        let combined = LolayTrackerScope(global.components + local.components)
        #expect(combined.components == ["App", "Search"])
    }
}
