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

    func testStringPrettyString() {
        let string =
        """
            {"name":"John", "age":30, "car":"BMW"}
        """
        /*
         """
         {
             "name":"John",
             "age":30,
             "car":"BMW"
         }
         """
         */
        XCTAssertNotEqual(string.sw.prettyString, string)
    }

    func testStringJson() {
        let string =
        """
            {"name":"John", "age":30, "car":"BMW"}
        """
        XCTAssertEqual(string.sw.json!["name"] as! String, "John")
    }

    func testStringPhoneNumberFormatString() {
        let string = "01012345678"
        XCTAssertEqual(string.sw.phoneNumberFormatString, "010-1234-5678")
    }

}
