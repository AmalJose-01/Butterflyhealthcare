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
        
                app.tables/*@START_MENU_TOKEN@*/.staticTexts["2023-12-15"]/*[[".cells.staticTexts[\"2023-12-15\"]",".staticTexts[\"2023-12-15\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Movie Detail"].buttons["Movie"].tap()
        
        XCUIApplication().tables.children(matching: .cell).element(boundBy: 18).children(matching: .other).element(boundBy: 1).swipeUp()
        let movieButton = app.navigationBars["Movie Detail"].buttons["Movie"]
        movieButton.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["When a peaceful colony on the edge of the galaxy finds itself threatened by the armies of the tyrannical Regent Balisarius, they dispatch Kora, a young woman with a mysterious past, to seek out warriors from neighboring planets to help them take a stand."]/*[[".cells.staticTexts[\"When a peaceful colony on the edge of the galaxy finds itself threatened by the armies of the tyrannical Regent Balisarius, they dispatch Kora, a young woman with a mysterious past, to seek out warriors from neighboring planets to help them take a stand.\"]",".staticTexts[\"When a peaceful colony on the edge of the galaxy finds itself threatened by the armies of the tyrannical Regent Balisarius, they dispatch Kora, a young woman with a mysterious past, to seek out warriors from neighboring planets to help them take a stand.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        movieButton.tap()
        app.tabBars["Tab Bar"].buttons["Search"].tap()
        app.searchFields["Search Movie"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["2020-01-01"]/*[[".cells.staticTexts[\"2020-01-01\"]",".staticTexts[\"2020-01-01\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Without warning, millions of mysterious alien “doors” suddenly appear around the globe. In a rush to determine the reason for their arrival, mankind must work together to understand the purpose of these cosmic anomalies."]/*[[".cells.staticTexts[\"Without warning, millions of mysterious alien “doors” suddenly appear around the globe. In a rush to determine the reason for their arrival, mankind must work together to understand the purpose of these cosmic anomalies.\"]",".staticTexts[\"Without warning, millions of mysterious alien “doors” suddenly appear around the globe. In a rush to determine the reason for their arrival, mankind must work together to understand the purpose of these cosmic anomalies.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
                
              
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
