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

    func testStackIsEmpty() throws {
        var stack = Stack<Int>()
        XCTAssertTrue(stack.isEmpty)
        stack.push(5)
        stack.push(7)
        XCTAssertEqual("5 7", stack.description)
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

    func testCurry() throws {
        func curryFunc(_ p1: Int, p2: Int, p3: Int) -> Int {
            p1 + p2 + p3
        }
        let cFunc1 = curry(curryFunc)
        let cFunc2 = cFunc1(1)
        let cFunc3 = cFunc2(2)
        let result = cFunc3(3)
        XCTAssertEqual(result, 6)
    }

    func testZipNil() throws {
        let arrayInt1 = [1, 2, 3]
        let arrayInt2: [Int]? = nil
        let result = zipWithNil(arrayInt1, arrayInt2)
        XCTAssertNil(result)
    }

    func testOperatorisNilOrEmpty() throws {
        let string = ""
        XCTAssertFalse(string⁇)
    }

    func testOperatorUnwrapDefaultValue() throws {
        let string: String? = nil
        XCTAssertEqual(string‽, "")
    }

    func testOperatorStringCompare() throws {
        let string1: String? = "abc"
        let string2: String? = "aBC"
        XCTAssertTrue(string1 ≡ string2)
    }
}

