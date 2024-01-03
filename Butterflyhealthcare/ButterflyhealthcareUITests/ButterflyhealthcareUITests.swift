//
//  ButterflyhealthcareUITests.swift
//  ButterflyhealthcareUITests
//
//  Created by Gerald George on 29/12/2023.
//

import XCTest

final class ButterflyhealthcareUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.exists)
        tabBar.buttons["Search"].tap()
        
        let searchField = app.searchFields["Search Movie"]
        XCTAssert(searchField.exists)
        searchField.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mithi develops an unlikely friendship with a malfunctioning robot named ANi. Together, they embark on a quest to look for magical grains that Mithi believes will save his grandfather's life."]/*[[".cells.staticTexts[\"Mithi develops an unlikely friendship with a malfunctioning robot named ANi. Together, they embark on a quest to look for magical grains that Mithi believes will save his grandfather's life.\"]",".staticTexts[\"Mithi develops an unlikely friendship with a malfunctioning robot named ANi. Together, they embark on a quest to look for magical grains that Mithi believes will save his grandfather's life.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tabBar.buttons["Movie"].tap()
        
        let searchFieldMovie = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element
                searchFieldMovie.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["When a peaceful colony on the edge of the galaxy finds itself threatened by the armies of the tyrannical Regent Balisarius, they dispatch Kora, a young woman with a mysterious past, to seek out warriors from neighboring planets to help them take a stand."]/*[[".cells.staticTexts[\"When a peaceful colony on the edge of the galaxy finds itself threatened by the armies of the tyrannical Regent Balisarius, they dispatch Kora, a young woman with a mysterious past, to seek out warriors from neighboring planets to help them take a stand.\"]",".staticTexts[\"When a peaceful colony on the edge of the galaxy finds itself threatened by the armies of the tyrannical Regent Balisarius, they dispatch Kora, a young woman with a mysterious past, to seek out warriors from neighboring planets to help them take a stand.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
       
                   
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
