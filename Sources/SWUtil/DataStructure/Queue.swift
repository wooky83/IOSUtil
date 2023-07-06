import Foundation

protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
    var count: Int { get }
}

struct QueueArray<T>: Queue {

    private var array: [T] = []

    init() { }

    init(_ elements: [T]) {
        array = elements
    }

    var count: Int {
        array.count
    }

    var isEmpty: Bool {
        array.isEmpty
    }

    var peek: T? {
        array.first
    }

    mutating func enqueue(_ element: T) {
        array.append(element)
    }

    @discardableResult
    mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        array = elements
    }
}

struct QueueStack<T>: Queue {
    private var dequeueStack: [T] = []
    private var enqueueStack: [T] = []

    init() { }

    init(_ elements: [T]) {
        enqueueStack = elements
    }

    var count: Int {
        dequeueStack.count + enqueueStack.count
    }

    var isEmpty: Bool {
        dequeueStack.isEmpty && enqueueStack.isEmpty
    }

    var peek: T? {
        !dequeueStack.isEmpty ? dequeueStack.last : enqueueStack.first
    }

    mutating func enqueue(_ element: T) {
        enqueueStack.append(element)
    }

    @discardableResult
    mutating func dequeue() -> T? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        return dequeueStack.popLast()
    }
}

extension QueueStack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        enqueueStack = elements
    }
}
