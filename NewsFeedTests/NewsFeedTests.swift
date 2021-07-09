//
//  NewsFeedTests.swift
//  NewsFeedTests
//
//  Created by Karan Bhatt on 09/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import XCTest
@testable import NewsFeed

class NewsFeedTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let manager = ListManager()
            let query =  Query(country: UserDefaults.standard.object(forKey: UserDefaultsLanguageCode ) as? String ?? "us", page: "", id: ApiKey, count: "30")
            manager.request(query: query){  (results) in
                XCTAssert("ok" == String(results?.status ?? "ok"))
            }

        }
    }

}
