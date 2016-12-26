import XCTest
@testable import Log4Swift

class Log4SwiftTests: XCTestCase {
    
    var logFilePath: String = String()

    override func setUp() {
        super.setUp()
        logFilePath = (NSTemporaryDirectory() as NSString).appendingPathComponent("log.txt")
        let manager = FileManager.default
        if manager.fileExists(atPath: logFilePath) {
            try! manager.removeItem(atPath: logFilePath)
        }
    }
    
    func testPrint() {
        let log = Logger.logger()
        let handler = ConsoleLogHandler("test.out")
        log.registerHandler(handler)
        log.info("foo")
        log.warn("bar")
        log.error("baz")
        log.fatal("boo")
    }
    
    func testFile() {
        let log = Logger.logger()
        do {
            let handler = try FileLogHandler("test.file", outputPath: logFilePath)
            log.registerHandler(handler)
        } catch {
            XCTFail("Failed to register file handler")
        }
        log.info("foo")
        log.warn("bar")
        XCTAssert(FileManager.default.fileExists(atPath: logFilePath))
    }

    static var allTests : [(String, (Log4SwiftTests) -> () throws -> Void)] {
        return [
            ("testPrint", testPrint),
            ("testFile", testFile),
        ]
    }
}
