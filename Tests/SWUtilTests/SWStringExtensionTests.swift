import XCTest
@testable import SWUtil

final class SWStringExtensionTests: XCTestCase {

    public override func setUp() {
        super.setUp()
    }

    public override func tearDown() {
        super.tearDown()
    }

    func testStringDigit() throws {
        let string = "가나다83라마바사"
        XCTAssertEqual("83", string.digits)
    }

    func testStringTrim() {
        let string = " Content \n"
        XCTAssertEqual("Content", string.trim())
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
        XCTAssertNotEqual(string.prettyString, string)
    }

    func testStringJson() {
        let string =
        """
            {"name":"John", "age":30, "car":"BMW"}
        """
        XCTAssertEqual(string.json!["name"] as! String, "John")
    }

    func testStringJsonNil() {
        let string = "123"
        XCTAssertNil(string.json)

        XCTAssertEqual(string.prettyString, string)
    }

    func testStringUrlEncode() {
        let string = "한글"
        XCTAssertEqual(string.urlEncoded, "%ED%95%9C%EA%B8%80")
    }

    func testPhoneNumberFormatString() {
        let string = "01012345678"
        XCTAssertEqual(string.phoneNumberFormatString, "010-1234-5678")
    }

    func testPhoneNumberFormatStringNot() {
        let string = "abcdefghi"
        XCTAssertEqual(string.phoneNumberFormatString, string)
    }

    func testStringBase64Encoding() throws {
        let string = "12345?*"
        XCTAssertEqual(string.base64Encoded, "MTIzNDU/Kg==")
    }

    func testStringBase64Decoding() {
        let string = "MTIzNDU/Kg=="
        XCTAssertEqual(string.base64Decoded, "12345?*")
    }

    func testStringSubscriptClosed() {
        let string = "hello, world!"
        XCTAssertEqual(string[0...5], "hello,")
        XCTAssertEqual(string[5...10], ", worl")
    }

    func testStringSubscriptRange() {
        let string = "hello, world!"
        XCTAssertEqual(string[0..<5], "hello")
        XCTAssertEqual(string[5..<10], ", wor")
    }

    func testStringSubscriptPartialThrough() {
        let string = "hello, world!"
        XCTAssertEqual(string[0...5], "hello,")
        XCTAssertEqual(string[0..<5], "hello")
    }

    func testStringSubscriptPartialFrom() {
        let string = "hello, world!"
        XCTAssertEqual(string[5...], ", world!")
    }

    func testIsValidEmail() {
        let string1 = "abc@hi.net"
        XCTAssertTrue(string1.isValidEmail)
        let string2 = "abchi.net"
        XCTAssertFalse(string2.isValidEmail)
        let string3 = "abc@hinet"
        XCTAssertFalse(string3.isValidEmail)
    }
}
