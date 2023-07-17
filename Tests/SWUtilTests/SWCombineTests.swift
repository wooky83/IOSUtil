import XCTest
import Combine
@testable import SWUtil

final class SWCombineTests: XCTestCase {

    func testSkipNil() throws {
        var cancellables = Set<AnyCancellable>()
        let subject = PassthroughSubject<Int?, Never>()
        var result = [Int]()
        subject
            .skipNil()
            .sink {
                result.append($0)
            }
            .store(in: &cancellables)
        subject.send(1)
        subject.send(nil)
        subject.send(2)
        XCTAssertEqual(result, [1, 2])
    }

}
