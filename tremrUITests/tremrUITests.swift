//
//  tremrUITests.swift
//  tremrUITests
//
//  Created by nklaasse on 10/22/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import XCTest

class tremrUITests: XCTestCase {
        
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
    
    func testViewResults() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        
        XCTAssert(app.buttons["View Results"].exists)
        XCTAssert(app.buttons["Measure"].exists)
        XCTAssert(app.buttons["Medication"].exists)
        XCTAssert(app.buttons["Exercise"].exists)
        
        app.buttons["View Results"].tap()
        
        XCTAssert(app.buttons["Week"].exists)
        XCTAssert(app.buttons["Month"].exists)
        XCTAssert(app.buttons["Year"].exists)
        
        app/*@START_MENU_TOKEN@*/.buttons["Month"]/*[[".segmentedControls.buttons[\"Month\"]",".buttons[\"Month\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(app.buttons["Week"].exists)
        XCTAssert(app.buttons["Month"].exists)
        XCTAssert(app.buttons["Year"].exists)
        
        app/*@START_MENU_TOKEN@*/.buttons["Year"]/*[[".segmentedControls.buttons[\"Year\"]",".buttons[\"Year\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(app.buttons["Week"].exists)
        XCTAssert(app.buttons["Month"].exists)
        XCTAssert(app.buttons["Year"].exists)
        
        app/*@START_MENU_TOKEN@*/.buttons["Week"]/*[[".segmentedControls.buttons[\"Week\"]",".buttons[\"Week\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(app.buttons["Week"].exists)
        XCTAssert(app.buttons["Month"].exists)
        XCTAssert(app.buttons["Year"].exists)
        
        app.buttons["Go to Previous View"].tap()
        
        XCTAssert(app.buttons["View Results"].exists)
        XCTAssert(app.buttons["Measure"].exists)
        XCTAssert(app.buttons["Medication"].exists)
        XCTAssert(app.buttons["Exercise"].exists)
        
    }
    
    func testMedication(){
        
    }
    
    func testExercise(){
        
    }
    
    func testMeasure(){
        
        let app = XCUIApplication()
        
        XCTAssert(app.buttons["View Results"].exists)
        XCTAssert(app.buttons["Measure"].exists)
        XCTAssert(app.buttons["Medication"].exists)
        XCTAssert(app.buttons["Exercise"].exists)
        
        app.buttons["Measure"].tap()
        
        XCTAssert(app.buttons["Back"].exists)
        XCTAssert(app.buttons["NEXT"].exists)
        
        app.buttons["NEXT"].tap()
        
        let startRecordingButton = app.buttons["Start Recording"]
        
        sleep(2)
        
        XCTAssert(app.buttons["Start Recording"].exists)
        
        startRecordingButton.tap()
        
        sleep(10)
        
        XCTAssert(app.buttons["Start Recording"].exists)
        
        startRecordingButton.tap()
        
        sleep(10)
        
        XCTAssert(app.buttons["Done"].exists)
        
        app.buttons["Done"].tap()
        
        XCTAssert(app.buttons["View Results"].exists)
        XCTAssert(app.buttons["Measure"].exists)
        XCTAssert(app.buttons["Medication"].exists)
        XCTAssert(app.buttons["Exercise"].exists)
        
        
        
    }
}
