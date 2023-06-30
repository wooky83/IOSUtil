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
}
