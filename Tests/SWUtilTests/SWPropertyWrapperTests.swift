import XCTest
@testable import SWUtil

final class SWPropertyWrapperTests: XCTestCase {

    func testUserDefaultWrapper() throws {
        @UserDefaultWrapper(key: #keyPath(name), defaultValue: "sung")
        var name: String
        XCTAssertEqual(name, "sung")
        name = "wooky"
        let value = UserDefaults.standard.object(forKey: "name") as? String
        XCTAssertEqual(value, "wooky")
    }
}
