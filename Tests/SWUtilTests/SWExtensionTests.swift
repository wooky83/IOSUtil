import XCTest
@testable import SWUtil

final class SWExtensionTests: XCTestCase {

    public override func setUp() {
        super.setUp()
    }

    public override func tearDown() {
        super.tearDown()
    }

    /// SW Extension Tests

    func testSWArraySafeSubscript() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.sw[safe: 2], 3)
        XCTAssertNil(array.sw[safe: 6])
    }

    func testSWStringTrim() {
        let string = " Content \n"
        XCTAssertEqual("Content", string.sw.trim())
    }

    /// Collection Tests

    func testArrayCircular() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array[circular: 0], 1)
        XCTAssertEqual(array[circular: 5], 1)
        XCTAssertEqual(array[circular: 6], 2)
        XCTAssertEqual(array[circular: -2], 4)
        XCTAssertEqual(array[circular: -8], 3)
    }

    func testArraySafeSubscript() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array[safe: 2], 3)
        XCTAssertNil(array[safe: 6])
    }

    func testArrayRemoveDuplicated() {
        let array = [1, 1, 1, 2, 2, 3, 4, 5]
        let removeDuplicatedArray = array.arrayDeduplicated
        XCTAssertEqual(removeDuplicatedArray, [1, 2, 3, 4, 5])
    }

    // Data Tests

    func testDataBase64Encoding() {
        let stringData = "?name=wooky&age=38".data(using: .utf8)!
        XCTAssertEqual(stringData.base64URLEncodedString, "P25hbWU9d29va3kmYWdlPTM4")
    }

    // Dictionary Tests

    func testDictionaryPlus() {
        var dic1 = ["a": "1"]
        let dic2 = ["b": "2", "a": "3"]
        let dic3 = dic1 + dic2
        dic1 += dic2
        XCTAssertEqual(dic1, ["a": "3", "b": "2"])
        XCTAssertEqual(dic3, ["a": "3", "b": "2"])
    }

#if canImport(UIKit)
    func testViewframe() {
        let view = UIView(frame: CGRect(x: 5, y: 10, width: 15, height: 20))
        XCTAssertEqual(view.frameX, 5)
        XCTAssertEqual(view.frameY, 10)
        XCTAssertEqual(view.frameWidth, 15)
        XCTAssertEqual(view.frameHeight, 20)
        XCTAssertEqual(view.frameBottom, 30)
    }
#endif

}
