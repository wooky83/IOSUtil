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
    
    func testUIViewEx() {
        let view = UIView(frame: CGRect(x: 10, y: 11, width: 12, height: 13))
        XCTAssert(view.frame.origin.x == view.frameX, "Fail")
    }
    
    func testJsonStrFormat() {
        let dic = ["name": "sung", "age": "37"]
        guard let jsonString = Utility.jsonStringFromDictionary(dic) else {
            preconditionFailure("fail")
        }
        XCTAssert(jsonString.contains("name"))
    }
    
    func testJsonDicFormat() {
        let jsonStr = """
            {"name": "wook", "age": 27}
            """
        guard let dic = Utility.dictionaryFromJsonString(jsonStr) else {
            preconditionFailure("fail")
        }
        XCTAssert(dic["name"] as! String == "wook" && dic["age"] as! Int == 27)
    }
    
   
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
