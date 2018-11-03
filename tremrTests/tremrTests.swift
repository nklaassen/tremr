//
//  tremrTests.swift
//  tremrTests
//
//  Created by nklaasse on 10/22/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import XCTest
@testable import tremr

class tremrTests: XCTestCase {
    
    //Calendar for comparing dates and performing date arithmetic
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)

    //MARK: Medication Tests
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddMedication() {
        db.addMedicine(UID: 1,
                       name: "medicine1",
                       dosage: "100",
                       monday: true,
                       tuesday: true,
                       wednesday: true,
                       thursday: true,
                       friday: true,
                       saturday: false,
                       sunday: false,
                       reminder: false,
                       start_date: Date(),
                       end_date: nil)
        let medications = db.getMedicine()
        
        XCTAssert(medications.count as Int == 1)
        print(medications[0].name)
        XCTAssert(medications[0].name == "medicine1")
        XCTAssert(medications[0].dosage == "100")
        XCTAssert(medications[0].mo == true)
        XCTAssert(medications[0].tu == true)
        XCTAssert(medications[0].we == true)
        XCTAssert(medications[0].th == true)
        XCTAssert(medications[0].fr == true)
        XCTAssert(medications[0].sa == false)
        XCTAssert(medications[0].su == false)
        XCTAssert(medications[0].reminder == false)
        XCTAssert(calendar.compare(medications[0].start_date, to: Date(), toGranularity: Calendar.Component.day) == ComparisonResult.orderedSame)
        XCTAssertNil(medications[0].end_date)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
