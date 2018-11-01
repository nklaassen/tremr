//
//  DbTest.swift
//  tremrTests
//
//  Created by nklaasse on 11/1/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import XCTest
@testable import tremr

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
