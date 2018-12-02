//
//  Name of file: tremrUITests.swift
//  Programmers: Nic Klaassen
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-11-04: Class created
//          2018-11-12: Created tests for UI
//          2018-11-20: Updated tests
// Known Bugs: N/A

import XCTest

//Class for testing the features for the UI
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
        
        app.buttons["Back"].tap()
        
        XCTAssert(app.buttons["View Results"].exists)
        XCTAssert(app.buttons["Measure"].exists)
        XCTAssert(app.buttons["Medication"].exists)
        XCTAssert(app.buttons["Exercise"].exists)
        
    }
    
    func testMedication(){
        
        
        
        let app = XCUIApplication()
        
        XCTAssert(app.buttons["View Results"].exists)
        XCTAssert(app.buttons["Measure"].exists)
        XCTAssert(app.buttons["Medication"].exists)
        XCTAssert(app.buttons["Exercise"].exists)
        
        app.buttons["Medication"].tap()
        
        XCTAssert(app.buttons["Edit/Add Medications"].exists)
        XCTAssert(app.buttons["R-Arrow"].exists)
        XCTAssert(app.buttons["L-Arrow"].exists)
        
        let rArrowButton = app.buttons["R-Arrow"]
        rArrowButton.tap()
        //sleep(1)
        rArrowButton.tap()
        //sleep(1)
        app.buttons["L-Arrow"].tap()
        //sleep(1)
        
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["medicine1"]/*[[".cells.staticTexts[\"medicine1\"]",".staticTexts[\"medicine1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let medicine2StaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["medicine2"]/*[[".cells.staticTexts[\"medicine2\"]",".staticTexts[\"medicine2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        medicine2StaticText.tap()
        app.buttons["Edit/Add Medications"].tap()
        
        XCTAssert(app.buttons["Add Medication"].exists)
        XCTAssert(app.buttons["Back"].exists)
        
        medicine2StaticText.tap()
        //medicine2StaticText.typeText("new")
        
        let enterMedicineNameTextField = app.textFields["Enter medicine name"]
        enterMedicineNameTextField.tap()
        
        let enterDosageAmountMgTextField = app.textFields["Enter dosage amount (mg)"]
        enterDosageAmountMgTextField.tap()
        
        XCTAssert(app.buttons["Update Medicine"].exists)
        XCTAssert(app.buttons["Cancel"].exists)
        
        let window = app.children(matching: .window).element(boundBy: 0)
        let element3 = window.children(matching: .other).element(boundBy: 2).children(matching: .other).element
        let element = element3.children(matching: .other).element(boundBy: 1)
        element.children(matching: .button).matching(identifier: "No").element(boundBy: 0).tap()
        element.children(matching: .button).matching(identifier: "Yes").element(boundBy: 2).tap()
        element.children(matching: .button).matching(identifier: "Yes").element(boundBy: 3).tap()
        element.children(matching: .button).matching(identifier: "No").element(boundBy: 2).tap()
        element3.children(matching: .button)["No"].tap()
        app.buttons["Update Medicine"].tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"medicine1")/*[[".cells.containing(.staticText, identifier:\"100\")",".cells.containing(.staticText, identifier:\"medicine1\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Button"].tap()
        app.buttons["Add Medication"].tap()
        enterMedicineNameTextField.tap()
        
        XCTAssert(app.buttons["Add Medicine"].exists)
        XCTAssert(app.buttons["Cancel"].exists)
        
        enterMedicineNameTextField.typeText("medication3")
        
        enterDosageAmountMgTextField.tap()
        
        enterDosageAmountMgTextField.typeText("300")
        
        let element2 = window.children(matching: .other).element(boundBy: 4).children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        element2.children(matching: .button).matching(identifier: "No").element(boundBy: 0).tap()
        
        let noButton = element2.children(matching: .button).matching(identifier: "No").element(boundBy: 1)
        noButton.tap()
        noButton.tap()
        element2.children(matching: .button).matching(identifier: "No").element(boundBy: 2).tap()
        //element2.children(matching: .button).matching(identifier: "No").element(boundBy: 3).tap()
        app.buttons["Add Medicine"].tap()
        
        let backButton = app.buttons["Back"]
        backButton.tap()
        rArrowButton.tap()
        rArrowButton.tap()
        rArrowButton.tap()
        backButton.tap()
     
        XCTAssert(app.buttons["View Results"].exists)
        XCTAssert(app.buttons["Measure"].exists)
        XCTAssert(app.buttons["Medication"].exists)
        XCTAssert(app.buttons["Exercise"].exists)
    
    }
    
    func testExercise(){
        
        let app = XCUIApplication()
        
        XCTAssert(app.buttons["View Results"].exists)
        XCTAssert(app.buttons["Measure"].exists)
        XCTAssert(app.buttons["Medication"].exists)
        XCTAssert(app.buttons["Exercise"].exists)
        
        app.buttons["Exercise"].tap()
        
        XCTAssert(app.buttons["Edit/Add Exercises"].exists)
        XCTAssert(app.buttons["R-Arrow"].exists)
        XCTAssert(app.buttons["L-Arrow"].exists)
        
        let rArrowButton = app.buttons["R-Arrow"]
        rArrowButton.tap()
        rArrowButton.tap()
        
        let lArrowButton = app.buttons["L-Arrow"]
        lArrowButton.tap()
        lArrowButton.tap()
        app.buttons["Edit/Add Exercises"].tap()
        
        XCTAssert(app.buttons["Add Exercise"].exists)
        XCTAssert(app.buttons["Back"].exists)
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Exercise1"]/*[[".cells.staticTexts[\"Exercise1\"]",".staticTexts[\"Exercise1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(app.buttons["Update Exercise"].exists)
        XCTAssert(app.buttons["Cancel"].exists)
        
        let window = app.children(matching: .window).element(boundBy: 0)
        let element3 = window.children(matching: .other).element(boundBy: 2).children(matching: .other).element
        let element = element3.children(matching: .other).element(boundBy: 1)
        element.children(matching: .button).matching(identifier: "Yes").element(boundBy: 1).tap()
        element.children(matching: .button).matching(identifier: "Yes").element(boundBy: 2).tap()
        element.children(matching: .button).matching(identifier: "Yes").element(boundBy: 3).tap()
        element3.children(matching: .button)["No"].tap()
        app.buttons["Update Exercise"].tap()
        
        let addExerciseButton = app.buttons["Add Exercise"]
        addExerciseButton.tap()
        
        XCTAssert(app.buttons["Add Exercise"].exists)
        XCTAssert(app.buttons["Back"].exists)
        
        app.textFields["Enter exercise name"].tap()
        app.textFields["Enter exercise name"].typeText("exercise2")
        app.textFields["Enter units performed"].tap()
        app.textFields["Enter units performed"].typeText("25")
        
        let element2 = window.children(matching: .other).element(boundBy: 4).children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        element2.children(matching: .button).matching(identifier: "No").element(boundBy: 1).tap()
        element2.children(matching: .button).matching(identifier: "No").element(boundBy: 2).tap()
        addExerciseButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Exercise1")/*[[".cells.containing(.staticText, identifier:\"100\")",".cells.containing(.staticText, identifier:\"Exercise1\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Button"].tap()
        
        let backButton = app.buttons["Back"]
        backButton.tap()
        backButton.tap()
        
        XCTAssert(app.buttons["View Results"].exists)
        XCTAssert(app.buttons["Measure"].exists)
        XCTAssert(app.buttons["Medication"].exists)
        XCTAssert(app.buttons["Exercise"].exists)
        
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
        
        sleep(17)
        
        XCTAssert(app.buttons["Start Recording"].exists)
        
        startRecordingButton.tap()
        
        sleep(17)
        
        XCTAssert(app.buttons["Done"].exists)
        
        app.buttons["Done"].tap()
        
        XCTAssert(app.buttons["View Results"].exists)
        XCTAssert(app.buttons["Measure"].exists)
        XCTAssert(app.buttons["Medication"].exists)
        XCTAssert(app.buttons["Exercise"].exists)
        
        
        
    }
}
