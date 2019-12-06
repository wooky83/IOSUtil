//
//  Swift-Prefix.swift
//  iOSUtil
//
//  Created by 1002659 on 06/12/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import Foundation
import os

func curry<X, Y>(_ f: @escaping (X)->Y) ->(X) -> Y {
    return { X -> Y in f(X) }
}

func curry<X, Y, Z>(_ f:@escaping (X,Y)->Z)->(X)->(Y)->Z {
    return { X in { Y in f(X,Y) } }
}

func curry<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in { b in { c in f(a, b, c) } } }
}

@inlinable func zipWithNil<Sequence1, Sequence2>(_ sequence1: Sequence1?, _ sequence2: Sequence2?) -> Zip2Sequence<Sequence1, Sequence2>? where Sequence1 : Sequence, Sequence2 : Sequence {
    guard let seq1 = sequence1, let seq2 = sequence2 else { return nil }
    return zip(seq1, seq2)
}

//String Value operator
//nil or empty 일 경우 false
postfix operator ^^
postfix func ^^(lhs: String?) -> Bool {
    guard let str = lhs else { return false }
    return !str.trimmingCharacters(in: .whitespaces).isEmpty
}
postfix func ^^<T: SignedInteger>(lhs: T?) -> Bool {
    guard let number = lhs else { return false }
    return number > 0
}

postfix operator •
postfix func •(lhs: String?) -> String {
    lhs ?? ""
}

func println(_ object: Any, file:String = #file, fnc:String = #function, line:(Int)=#line) {
    #if Debug
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let className = file.components(separatedBy: "/").last
        Swift.print("[\(formatter.string(from: Date()))][\(className!.components(separatedBy: ".").first!) \(fnc)][Line \(line)] \(object)")
    #endif
}

public func delay(_ when: Double, _ block: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(when * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: block)
}

enum Console {
    static func log(_ msg: StaticString, category: String = "wooky", _ args: CVarArg...) {
        #if Debug
        let subSystem = Bundle.main.bundleIdentifier!
        let ocbOSLog = OSLog(subsystem: subSystem, category: category)
        switch args.count {
        case 0:
            os_log(msg, log: ocbOSLog, type: .fault)
        case 1:
            os_log(msg, log: ocbOSLog, type: .fault, args[0])
        case 2:
            os_log(msg, log: ocbOSLog, type: .fault, args[0], args[1])
        case 3:
            os_log(msg, log: ocbOSLog, type: .fault, args[0], args[1], args[2])
        case 4:
            os_log(msg, log: ocbOSLog, type: .fault, args[0], args[1], args[2], args[3])
        case 5:
            os_log(msg, log: ocbOSLog, type: .fault, args[0], args[1], args[2], args[3], args[4])
        case 6:
            os_log(msg, log: ocbOSLog, type: .fault, args[0], args[1], args[2], args[3], args[4], args[5])
        default:
            NSLog("Too Many Arguments!!")
        }
        #endif
    }
}
