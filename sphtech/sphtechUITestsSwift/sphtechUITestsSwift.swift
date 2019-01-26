//
//  sphtechUITestsSwift.swift
//  sphtechUITestsSwift
//
//  Created by Michael Ugale on 1/23/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

import XCTest

class sphtechUITestsSwift: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInteractions() {
        
        let app = XCUIApplication()
        app.collectionViews.cells.element(boundBy:0).tap()
    }
}
