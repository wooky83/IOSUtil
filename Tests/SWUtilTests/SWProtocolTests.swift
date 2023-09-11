import XCTest
@testable import SWUtil

final class SWProtocolTests: XCTestCase {

    func testAnyOptional() throws {
        var optionalValue: Int? = 5
        XCTAssertFalse(optionalValue.isNil)
        optionalValue = nil
        XCTAssertTrue(optionalValue.isNil)
    }

    func testEnumCodable() throws {

        struct MyPerson: Codable {
            let id: String
            let day: DayByDay
            enum DayByDay: String, EnumCodable {
                case sunday
                case monday
                case unknown
                static var errorCase: DayByDay = .unknown
            }
        }

        let jsonString =
        """
        {
            "id" : "hello",
            "day" : "monday"
        }
        """

        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)!
        let myPerson = try? decoder.decode(MyPerson.self, from: data)
        XCTAssertNotNil(myPerson)
        XCTAssertEqual(myPerson?.day, .monday)
    }

    func testThenThen() throws {
        class MyClass: NSObject {
            var value: String?
        }
        let object = MyClass().then {
            $0.value = "hello"
        }
        XCTAssertEqual("hello", object.value)
    }

    func testThenWith() throws {
        let rect = CGRect.zero
        let frame = rect.with {
            $0.origin.x = 10
            $0.size.width = 100
        }
        XCTAssertEqual(rect, CGRect.zero)
        XCTAssertEqual(frame, CGRect(x: 10, y: 0, width: 100, height: 0))
    }

    func testThenDo() throws {
        class MyClass: NSObject {
            var value: String?
        }
        let object = MyClass()
        object.do {
            $0.value = "hello"
        }
        XCTAssertEqual("hello", object.value)
    }
}
