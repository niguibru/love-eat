//
//  LoveEatUITests.swift
//  LoveEatUITests
//
//  Created by Nicolas Brucchieri on 08/04/2021.
//

import XCTest

class LoveEatUITests: XCTestCase {

    let app = XCUIApplication()
    
    func testUI() throws {
        app.launch()

        // Check that the list exist
        let dishList = app.otherElements["dish-list"]
        XCTAssertTrue(dishList.waitForExistence(timeout: 5))
        
        // Check that the list contains 3 elements
        let buttons = dishList.buttons
        XCTAssertTrue(buttons.count == 3)
        
        // Tap first item and check that it is the correct one
        buttons.element(boundBy: 0).tap()
        checkDetailPage(title: "Mila napolitana con papas", imageName: "mila")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Tap second item and check that it is the correct one
        buttons.element(boundBy: 1).tap()
        checkDetailPage(title: "Cheescake", imageName: "cheescake")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Tap second item and check that it is the correct one
        buttons.element(boundBy: 2).tap()
        checkDetailPage(title: "Croissant", imageName: "croissant")
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    // MARK: Helpers
    func checkDetailPage(title: String, imageName: String) {
        XCTAssertTrue(app.images[imageName].exists) // Check for correct image
        XCTAssertTrue(app.staticTexts[title].exists) // Check for correct name
        XCTAssertTrue(app.staticTexts["Ingredients:"].exists) // Check if Ingredients is showing
        XCTAssertTrue(app.staticTexts["Steps:"].exists) // Check if Steps is showing
    }
}
