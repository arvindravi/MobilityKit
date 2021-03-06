import XCTest
@testable import MobilityKit

final class MobilityKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MobilityKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
