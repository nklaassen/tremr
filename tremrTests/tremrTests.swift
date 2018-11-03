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
    
    //DateFormatter for creating specific dates
    let dateFormatter = DateFormatter()
    
    
    //MARK: Medication Tests
    override func setUp() {
        super.setUp()
        
        //Remove all medications in database
        db.clearMedicine()
        
        //Setup the dateFormatter, both these lines are required to use dateFormatter
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
    }
    
    override func tearDown() {
        //Remove all newly added medications in database
        db.clearMedicine()
        super.tearDown()
    }
    
    func testAddMedication() {
        db.addMedicine(UID: 1,
                       name: "medicine1",
                       dosage: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: true,
                       reminder: false,
                       start_date: Date(),
                       end_date: nil)
        let medications = db.getMedicine()
        
        XCTAssert(medications.count as Int == 1)
        XCTAssert(medications[0].name == "medicine1")
        XCTAssert(medications[0].dosage == "100")
        XCTAssert(medications[0].mo == true)
        XCTAssert(medications[0].tu == true)
        XCTAssert(medications[0].we == true)
        XCTAssert(medications[0].th == true)
        XCTAssert(medications[0].fr == true)
        XCTAssert(medications[0].sa == false)
        XCTAssert(medications[0].su == true)
        XCTAssert(medications[0].reminder == false)
        XCTAssert(calendar.compare(medications[0].start_date, to: Date(), toGranularity: Calendar.Component.day) == ComparisonResult.orderedSame)
        XCTAssertNil(medications[0].end_date)
    }
    
    func testSelectMedicationsRightDayOfWeek() {
        let dateFri = dateFormatter.date(from: "Nov 2, 2018 at 11:14:31 AM PST")
        //print(dateFormatter.string(from: queryDate!))

        let day = TimeInterval(60*60*24) //Number of seconds in a day
        db.addMedicine(UID: 1,
                       name: "medicine1",
                       dosage: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(-day), // It wants me to use !, I think because queryDate could be nil, so if it is throw an exception
                       end_date: nil)
        db.addMedicine(UID: 1,
                       name: "medicine2",
                       dosage: "200",
                       mo: true, tu: true, we: true, th: true, fr: false, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(-day),
                       end_date: nil)
        
        let allMedications = db.getMedicine()
        let friMedications = db.getMedicineDate(date: dateFri!)
        
        XCTAssert(allMedications.count as Int == 2)
        XCTAssert(friMedications.count as Int == 1)
        XCTAssert(friMedications[0].name == "medicine1")
        
    }
    
}
