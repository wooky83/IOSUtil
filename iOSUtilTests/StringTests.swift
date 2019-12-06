//
//  StringTests.swift
//  iOSUtilTests
//
//  Created by wooky83 on 06/12/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import XCTest
@testable import iOSUtil

class StringTests: XCTestCase {
    
    func testAttributedString() {
        let attributeStr = "ab<u>cde</u>fg".attributedStringFromHtml(familyName: "AppleSDGothicNeo-Bold", fontSize: 17)
        let label = UILabel()
        label.attributedText = attributeStr
        print(label.font.familyName)
        XCTAssert(label.font.familyName == "Apple SD Gothic Neo", "Fail")
    }
    
    func testStringDigits() {
        let number = "$123,456,78%".digits
        XCTAssert(Int(number)! == 12345678)
    }
    
    func testStrEmptyValue() {
        let str = " Good  ".trimmingCharacters(in: .whitespacesAndNewlines)
        XCTAssert(str == "Good")
    }
    
    
}
