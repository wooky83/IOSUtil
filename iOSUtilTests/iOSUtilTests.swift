//
//  iOSUtilTests.swift
//  iOSUtilTests
//
//  Created by wooky83 on 22/02/2019.
//  Copyright © 2019 wooky. All rights reserved.
//

import XCTest
@testable import iOSUtil

class iOSUtilTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAttributedString() {
        let attributeStr = "ab<u>cde</u>fg".attributedStringFromHtml(familyName: "AppleSDGothicNeo-Bold", fontSize: 17)
        let label = UILabel()
        label.attributedText = attributeStr
        print(label.font.familyName)
        XCTAssert(label.font.familyName == "Apple SD Gothic Neo", "Fail")
    }
    
    func testKVC() {
        
        class Person: NSObject {
            @objc var name: String
            var age: Int
            init(name: String, age: Int) {
                self.name = name
                self.age = age
            }
        }
        let ps = Person(name: "wooky", age: 37)
        XCTAssert(ps.value(forKeyNil: "name") as! String == "wooky")
        ps.setValue("sung", forKeyNil: "name")
        XCTAssert(ps.value(forKeyNil: "name") as! String == "sung")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
