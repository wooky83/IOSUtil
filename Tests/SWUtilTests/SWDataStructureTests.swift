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

        var queueArray1 = QueueArray<Int>([1])
        queueArray1.dequeue()
        XCTAssertNil(queueArray1.dequeue())

        var queueArray2 = QueueArray<Int>()
        queueArray2.enqueue(1)
        XCTAssertEqual(queueArray2.dequeue(), 1)
    }

    func testQueueStack() throws {
        var queue: QueueStack<Int> = [1, 2, 3, 4, 5]
        XCTAssertEqual(queue.count, 5)
        XCTAssertEqual(queue.dequeue(), 1)
        queue.enqueue(0)
        XCTAssertEqual(queue.peek, 2)
    }

    func testCurry1() throws {
        func curryFunc(_ p1: Int) -> Int {
            p1
        }
        let cFunc1 = curry(curryFunc)
        let result = cFunc1(1)
        XCTAssertEqual(result, 1)
    }

    func testCurry2() throws {
        func curryFunc(_ p1: Int, p2: Int) -> Int {
            p1 + p2
        }
        let cFunc1 = curry(curryFunc)
        let cFunc2 = cFunc1(1)
        let result = cFunc2(2)
        XCTAssertEqual(result, 3)
    }

    func testCurry3() throws {
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

        let arrayInt3 = [1, 2, 3]
        let arrayInt4 = [6, 5, 4]
        let resultZip = zipWithNil(arrayInt3, arrayInt4)
        XCTAssertEqual(resultZip?.compactMap { $0.0 + $0.1 }, [7, 7, 7])
    }

    func testOperatorisNilOrEmpty() throws {
        let string1 = ""
        XCTAssertFalse(string1⁇)

        let string2: String? = nil
        XCTAssertFalse(string2⁇)

        let intNumber1 = 1
        XCTAssertTrue(intNumber1⁇)

        let intNumber2: Int? = nil
        XCTAssertFalse(intNumber2⁇)

        let floatNumber1: Float = 1
        XCTAssertTrue(floatNumber1⁇)

        let floatNumber2: Float? = nil
        XCTAssertFalse(floatNumber2⁇)

        let collection1 = [1]
        XCTAssertTrue(collection1⁇)

        let collection2: [Int]? = nil
        XCTAssertFalse(collection2⁇)
    }

    func testOperatorUnwrapDefaultValue() throws {
        let string: String? = nil
        XCTAssertEqual(string‽, "")

        let boolValue: Bool? = nil
        XCTAssertEqual(boolValue‽, false)

        let intNumber: Int? = nil
        XCTAssertEqual(intNumber‽, 0)

        let collection: [Int]? = nil
        XCTAssertEqual(collection‽, [])
    }

    func testOperatorStringCompare() throws {
        let string1: String? = "abc"
        let string2: String? = "aBC"
        XCTAssertTrue(string1 ≡ string2)

        let string3: String? = "abc"
        let string4: String? = nil
        XCTAssertFalse(string3 ≡ string4)
    }
}

