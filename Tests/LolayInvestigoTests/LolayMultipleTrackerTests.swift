import Foundation
import Testing
@testable import LolayInvestigo

@Suite("LolayMultipleTracker")
struct LolayMultipleTrackerTests {
    enum TestError: Error {
        case test
    }

    @Test func delegatesIdentifier() {
        let child1 = RecordingTracker()
        let child2 = RecordingTracker()
        let multi = LolayMultipleTracker(child1, child2)

        multi.setIdentifier("user-1")

        #expect(child1.identifiers == ["user-1"])
        #expect(child2.identifiers == ["user-1"])
    }

    @Test func delegatesVersion() {
        let child = RecordingTracker()
        let multi = LolayMultipleTracker(child)

        multi.setVersion("2.0")

        #expect(child.versions == ["2.0"])
    }

    @Test func delegatesEmail() {
        let child = RecordingTracker()
        let multi = LolayMultipleTracker(child)

        multi.setEmail("noreply@lolay.com")

        #expect(child.emails == ["noreply@lolay.com"])
    }

    @Test func delegatesName() {
        let child = RecordingTracker()
        let multi = LolayMultipleTracker(child)

        multi.setName("Some Name")

        #expect(child.names == ["Some Name"])
    }

    @Test func delegatesGlobalParameters() {
        let child1 = RecordingTracker()
        let child2 = RecordingTracker()
        let multi = LolayMultipleTracker(child1, child2)

        multi.setGlobalParameters(["B": "2", "C": "3"])

        #expect(child1.globalParams == ["B": "2", "C": "3"])
        #expect(child2.globalParams == ["B": "2", "C": "3"])
    }

    @Test func delegatesSetAndRemoveGlobalParameter() {
        let child = RecordingTracker()
        let multi = LolayMultipleTracker(child)

        multi.setGlobalParameter("1", forKey: "A")
        #expect(child.globalParams == ["A": "1"])

        multi.removeGlobalParameterForKey("A")
        #expect(child.globalParams.isEmpty)
    }

    @Test func delegatesFlatEvent() {
        let child1 = RecordingTracker()
        let child2 = RecordingTracker()
        let multi = LolayMultipleTracker(child1, child2)

        multi.logEvent("Name Only")
        multi.logEvent("With Dict", withDictionary: ["A": "1"])

        #expect(child1.events.count == 2)
        #expect(child1.events[0].name == "Name Only")
        #expect(child1.events[1].name == "With Dict")
        #expect(child1.events[1].parameters == ["A": "1"])

        #expect(child2.events.count == 2)
    }

    @Test func delegatesPage() {
        let child = RecordingTracker()
        let multi = LolayMultipleTracker(child)

        multi.logPage("Home")
        multi.logPage("Settings", withDictionary: ["tab": "general"])

        #expect(child.pages.count == 2)
        #expect(child.pages[0].name == "Home")
        #expect(child.pages[1].name == "Settings")
        #expect(child.pages[1].parameters == ["tab": "general"])
    }

    @Test func delegatesErrors() {
        let child = RecordingTracker()
        let multi = LolayMultipleTracker(child)

        multi.logError(TestError.test)
        multi.logError(NSError(domain: "TestDomain", code: 42))

        #expect(child.errors.count == 2)
        #expect(child.errors[1].domain == "TestDomain")
        #expect(child.errors[1].code == 42)
    }

    @Test func delegatesException() {
        let child = RecordingTracker()
        let multi = LolayMultipleTracker(child)

        multi.logException(NSException(name: .genericException, reason: "test"))

        #expect(child.exceptions == [NSExceptionName.genericException.rawValue])
    }

    @Test func delegatesStructuredEvent() {
        let child1 = RecordingTracker(naming: LolayDotNotationNaming(), globalScope: "App")
        let child2 = RecordingTracker(naming: LolaySnakeCaseNaming())
        let multi = LolayMultipleTracker(child1, child2)

        multi.logEvent(scope: "Lifecycle", action: "launched")

        #expect(child1.events.count == 1)
        #expect(child1.events[0].name == "App.Lifecycle.launched")
        #expect(child2.events.count == 1)
        #expect(child2.events[0].name == "lifecycle_launched")
    }

    @Test func delegatesStructuredEventWithParameters() {
        let child = RecordingTracker(naming: LolayDotNotationNaming())
        let multi = LolayMultipleTracker(child)

        multi.logEvent(scope: "Search", action: "performed",
                       parameters: ["source": "search", "type": "keyword"])

        #expect(child.events[0].parameters == ["source": "search", "type": "keyword"])
    }

    @Test func delegatesStructuredEventWithNumericValue() {
        let child = RecordingTracker(naming: LolayDotNotationNaming())
        let multi = LolayMultipleTracker(child)

        multi.logEvent(scope: "Index", action: "snapshot",
                       parameters: ["contentType": "public.png"],
                       numericValue: 47418)

        #expect(child.events[0].numericValue == 47418)
    }
}
