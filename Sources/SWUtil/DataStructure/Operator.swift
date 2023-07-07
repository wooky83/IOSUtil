import Foundation

public func curry<X, Y>(_ f: @escaping (X) -> Y) -> (X) -> Y {
    return { X -> Y in f(X) }
}

public func curry<X, Y, Z>(_ f:@escaping (X, Y)->Z)->(X)->(Y)->Z {
    return { X in { Y in f(X, Y) } }
}

public func curry<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in { b in { c in f(a, b, c) } } }
}

@inlinable func zipWithNil<Sequence1, Sequence2>(_ sequence1: Sequence1?, _ sequence2: Sequence2?) -> Zip2Sequence<Sequence1, Sequence2>? where Sequence1: Sequence, Sequence2: Sequence {
    guard let sequence1, let sequence2 else { return nil }
    return zip(sequence1, sequence2)
}

//nil or empty 일 경우 false
postfix operator ⁇
postfix public func ⁇<T: StringProtocol>(lhs: T?) -> Bool {
    guard let str = lhs else { return false }
    return !str.trimmingCharacters(in: .whitespaces).isEmpty
}

postfix public func ⁇<T: SignedInteger>(lhs: T?) -> Bool {
    guard let number = lhs else { return false }
    return number > 0
}

postfix public func ⁇<T: BinaryFloatingPoint>(lhs: T?) -> Bool {
    guard let number = lhs else { return false }
    return number > 0
}

postfix public func ⁇<T: Collection>(lhs: T?) -> Bool {
    guard let array = lhs else { return false }
    return !array.isEmpty
}

postfix operator ‽
postfix public func ‽(lhs: String?) -> String {
    lhs ?? ""
}

postfix public func ‽(lhs: Bool?) -> Bool {
    lhs ?? false
}

postfix public func ‽<T: SignedInteger>(lhs: T?) -> T {
    lhs ?? 0
}

postfix public func ‽<T: Collection>(lhs: T?) -> T {
    lhs ?? [T.Element]() as! T
}

//대소문자 구분없이 비교
infix operator ≡
public func ≡(lhs: String?, rhs: String?) -> Bool {
    guard let left = lhs, let right = rhs else { return false }
    return left.compare(right, options: .caseInsensitive) == .orderedSame
}
