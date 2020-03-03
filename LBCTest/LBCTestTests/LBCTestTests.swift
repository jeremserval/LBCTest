//
//  LBCTestTests.swift
//  LBCTestTests
//
//  Created by Jeremie Serval on 26/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import XCTest
@testable import LBCTest

class LBCTestTests: XCTestCase {

    func testLBCItem() {
        let item = LBCItem(id: 0, category_id: 0, title: "title", description: "description", price: 1.0, images_url: ["small" : "", "thumb": ""], creation_date: "date", is_urgent: false)
        
        XCTAssertFalse(item.is_urgent)
        XCTAssertEqual(item.id, 0)
        XCTAssertTrue(item.images_url.keys.contains("small"))
        XCTAssertTrue(item.images_url.keys.contains("thumb"))
        XCTAssertNotNil(item.title)
        XCTAssertEqual(item.priceString(), "1 €")
        
    }
    
    func testItemsDecoding() throws {
        let data = try Data(contentsOf: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!)
        
        XCTAssertNoThrow(try JSONDecoder().decode(Array<LBCItem>.self, from: data))
    }

    func testCategoriesDecoding() throws {
        let data = try Data(contentsOf: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!)
        XCTAssertNoThrow(try JSONDecoder().decode(Array<LBCCategory>.self, from: data))
    }

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
