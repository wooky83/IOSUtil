//
//  Utility.swift
//  iOSUtil
//
//  Created by wooky83 on 26/03/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import Foundation

enum Utility {
   
    // MARK: - Json String
    
    /// Dictionary를 Json Format의 String으로 변환하여준다
    ///
    /// - parameter dictionary:        Dictionary.
    ///
    /// - returns: Json String or nil.
    static func jsonStringFromDictionary(_ dictionary: [String: Any]) -> String? {
        do {
            let mData = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions(rawValue: UInt(0)))
            return String(data: mData, encoding: .utf8) ?? nil
        } catch {
            return nil
        }
    }
    
    // MARK: - Dictionary
    
    /// Json Format의 String을 Dictionary Type으로 변환하여준다
    /// `method`, `parameters`, `encoding` and `headers`.
    ///
    /// - parameter jsonString:        json Format String.
    ///
    /// - returns: Dictionary or nil.
    static func dictionaryFromJsonString(_ jsonString: String) -> [String: Any]? {
        let converStr = jsonString.replacingOccurrences(of: "\n", with: "\\n").replacingOccurrences(of: "\r", with: "\\r").replacingOccurrences(of: "\t", with: "\\t")
        guard let data = converStr.data(using: .utf8) else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            return nil
        }
    }
}



// MARK: - Json String

/// Creates a `DataRequest` using the default `SessionManager` to retrieve the contents of the specified `url`,
/// `method`, `parameters`, `encoding` and `headers`.
///
/// - parameter url:        The URL.
/// - parameter method:     The HTTP method. `.get` by default.
/// - parameter parameters: The parameters. `nil` by default.
/// - parameter encoding:   The parameter encoding. `URLEncoding.default` by default.
/// - parameter headers:    The HTTP headers. `nil` by default.
///
/// - returns: The created `DataRequest`.
