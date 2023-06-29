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

    func testViewframe() {
        let view = UIView(frame: CGRect(x: 5, y: 10, width: 15, height: 20))
        XCTAssertEqual(view.sw.frameX, 5)
        XCTAssertEqual(view.sw.frameY, 10)
        XCTAssertEqual(view.sw.frameWidth, 15)
        XCTAssertEqual(view.sw.frameHeight, 20)
        XCTAssertEqual(view.sw.frameBottom, 30)
    }

    func testArraySafeSubscript() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.sw[safe: 2], 3)
        XCTAssertNil(array.sw[safe: 6])
    }

    func testArrayRemoveDuplicated() {
        let array = [1, 1, 1, 2, 2, 3, 4, 5]
        let removeDuplicatedArray = array.sw.arrayDeduplicated
        XCTAssertEqual(removeDuplicatedArray, [1, 2, 3, 4, 5])
    }

}
