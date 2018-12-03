//
//  Mindvalley_TestUITests.swift
//  Mindvalley TestUITests
//
//  Created by Mobile World on 7/27/17.
//  Copyright © 2017 Coca Denisa. All rights reserved.
//

import XCTest

class Mindvalley_TestUITests: XCTestCase {
    
    let app = XCUIApplication()
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAppUIFlow() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let imageListTableView = app.tables["imageListTableView"]
        XCTAssertTrue(imageListTableView.exists, "The image list table view exists")

        if let tableViewCells = imageListTableView.cells as? XCUIElementQuery{
            if let tableCell = tableViewCells.element(boundBy: 0) as? XCUIElement{
                let searchText1 = "Likes:"
                let searchText2 = "Created:"
                let predicate1 = NSPredicate(format: "label CONTAINS[c] %@", searchText1)
                let predicate2 = NSPredicate(format: "label CONTAINS[c] %@", searchText2)

                let elementQuery1 = tableCell.staticTexts.containing(predicate1)
                let elementQuery2 = tableCell.staticTexts.containing(predicate2)
                if elementQuery1.count > 0 &&  elementQuery2.count > 0{
                    // the element exists
                    XCTAssertTrue(true, "There is valid data available")
                }

            }
        }
    }
    
}
