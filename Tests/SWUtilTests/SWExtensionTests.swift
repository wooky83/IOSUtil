import XCTest
@testable import SWUtil

final class SWExtensionTests: XCTestCase {

    func testStringDigit() throws {
        let string = "가나다83라마바사"
        XCTAssertEqual("83", string.sw.digits)
    }

    func testStringTrim() {
        let string = " Content \n"
        XCTAssertEqual("Content", string.sw.trim())
    }

}
