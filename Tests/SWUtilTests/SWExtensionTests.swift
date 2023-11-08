import XCTest
@testable import SWUtil

final class SWExtensionTests: XCTestCase {

    public override func setUp() {
        super.setUp()
    }

    public override func tearDown() {
        super.tearDown()
    }

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

    func testStringUrlEncode() {
        let string = "한글"
        XCTAssertEqual(string.sw.urlEncoded, "%ED%95%9C%EA%B8%80")
    }

    func testStringPhoneNumberFormatString() {
        let string = "01012345678"
        XCTAssertEqual(string.sw.phoneNumberFormatString, "010-1234-5678")
    }

    func testStringBase64Encoding() throws {
        let string = "12345?*"
        XCTAssertEqual(string.sw.base64Encoded, "MTIzNDU/Kg==")
    }

    func testStringBase64Decoding() {
        let string = "MTIzNDU/Kg=="
        XCTAssertEqual(string.sw.base64Decoded, "12345?*")
    }

    #if canImport(UIKit)
    func testViewframe() {
        let view = UIView(frame: CGRect(x: 5, y: 10, width: 15, height: 20))
        XCTAssertEqual(view.sw.frameX, 5)
        XCTAssertEqual(view.sw.frameY, 10)
        XCTAssertEqual(view.sw.frameWidth, 15)
        XCTAssertEqual(view.sw.frameHeight, 20)
        XCTAssertEqual(view.sw.frameBottom, 30)
    }
    #endif

    func testArrayCircular() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.sw[circular: 0], 1)
        XCTAssertEqual(array.sw[circular: 5], 1)
        XCTAssertEqual(array.sw[circular: 6], 2)
        XCTAssertEqual(array.sw[circular: -2], 4)
        XCTAssertEqual(array.sw[circular: -8], 3)
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

    #if canImport(UIKit)
    func testCGFloatAdjustWidth() {
        let width = CGFloat(100)
        XCTAssertEqual(floor(width.sw.adjust()), 104)
    }
    #endif

    func testDataBase64Encoding() {
        let stringData = "?name=wooky&age=38".data(using: .utf8)!
        XCTAssertEqual(stringData.sw.base64URLEncodedString, "P25hbWU9d29va3kmYWdlPTM4")
    }

    func testDictionaryPlus() {
        var dic1 = ["a": "1"]
        let dic2 = ["b": "2", "a": "3"]
        let dic3 = dic1 + dic2
        dic1 += dic2
        XCTAssertEqual(dic1, ["a": "3", "b": "2"])
        XCTAssertEqual(dic3, ["a": "3", "b": "2"])
    }
}
