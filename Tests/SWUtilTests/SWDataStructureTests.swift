import XCTest
@testable import SWUtil

final class SWDataStructureTests: XCTestCase {

    func testStack() throws {
        var stack: Stack<Int> = [1, 2, 3, 4, 5]
        XCTAssertEqual(stack.count, 5)
        XCTAssertEqual(stack.pop(), 5)
        XCTAssertEqual(stack.peek(), 4)
        stack.push(0)
        XCTAssertEqual(stack.peek(), 0)
    }

    func testQueueArray() throws {
        var queue: QueueArray<Int> = [1, 2, 3, 4, 5]
        XCTAssertEqual(queue.count, 5)
        XCTAssertEqual(queue.dequeue(), 1)
        queue.enqueue(0)
        XCTAssertEqual(queue.peek, 2)
    }

    func testQueueStack() throws {
        var queue: QueueStack<Int> = [1, 2, 3, 4, 5]
        XCTAssertEqual(queue.count, 5)
        XCTAssertEqual(queue.dequeue(), 1)
        queue.enqueue(0)
        XCTAssertEqual(queue.peek, 2)
    }

}
