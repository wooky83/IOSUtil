import Foundation

extension Dictionary {

    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        lhs.merging(rhs) { _, rhs in rhs }
    }

    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        lhs.merge(rhs) { _, rhs in rhs }
    }
}
