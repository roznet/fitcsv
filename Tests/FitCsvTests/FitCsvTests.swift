import XCTest
@testable import FitCsv

final class FitCsvTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FitCsv().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
