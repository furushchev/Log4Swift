import XCTest
@testable import Log4Swift

class Log4SwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Log4Swift().text, "Hello, World!")
    }


    static var allTests : [(String, (Log4SwiftTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
