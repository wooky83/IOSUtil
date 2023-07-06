//
//  File.swift
//  
//
//  Created by SungwookKwon on 2023/07/06.
//

import Foundation

extension Dictionary {

    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        lhs.merging(rhs) { current, _ in current }
    }

    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        lhs.merge(rhs) { current, _ in current }
    }
}
