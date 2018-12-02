//
//  Name of file: DbTest.swift
//  Programmers: Nic Klaassen
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-11-03: Class created
//          2018-11-06: Created tests for Database
//          2018-11-14: Updated tests
// Known Bugs: N/A

import XCTest
@testable import tremr

//Class for testing the database 
class DbTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // test some tremor functionality in the DatabaseManager, which implicitly tests that the db at least works.
    func testTremors() {
        let restingValue = 2.4
        let posturalValue = 4.3

        let db = DatabaseManager()
        db.addTremor(restingSeverity: restingValue, posturalSeverity: posturalValue)
        let tremors = db.getTremorsForLastWeek()

        XCTAssert(tremors.count >= 1 && tremors.count <= 7)

        let tremor = tremors.last!
        XCTAssert(fabs(tremor.restingSeverity - restingValue) < Double.ulpOfOne
            && fabs(tremor.posturalSeverity - posturalValue) < Double.ulpOfOne)
    }
    
}
