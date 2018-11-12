//
//  MedicationTests.swift
//  tremrTests
//
//  Created by Jason Fevang on 11/2/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import XCTest
@testable import tremr

class MedicationTests: XCTestCase {
    //Calendar for comparing dates and performing date arithmetic
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    //DateFormatter for creating specific dates
    let dateFormatter = DateFormatter()
    
    
    //MARK: Medication Tests
    override func setUp() {
        super.setUp()
        //Runs before every test method
        
        //Remove all medications in database
        db.clearMedicine()
        
        //Setup the dateFormatter, both these lines are required to use dateFormatter
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
    }
    
    override func tearDown() {
        //Runs after every test method
        
        //Remove all newly added medications in database
        db.clearMedicine()
        super.tearDown()
    }
    
    func testAddMedication() {
        let testDate = Date()
        
        let insertedMID = db.addMedicine(UID: 1,
                       name: "medicine1",
                       dosage: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: true,
                       reminder: false,
                       start_date: testDate,
                       end_date: nil)
        
        let medications = db.getMedicine()
        
        XCTAssert(medications[0].MID == insertedMID)
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
        //start_date is modified in the datebase to be the very start of the day, so only check for the day component to match
        XCTAssert(calendar.compare(medications[0].start_date, to: testDate, toGranularity: Calendar.Component.day) == ComparisonResult.orderedSame)
        //end_date is modified in the database to be the very start of the next day, so subtracting 1 second from it will be the same day as testDate
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
    
    func testSelectMedicationStartDateConsiderations() {
        let dateFri = dateFormatter.date(from: "Nov 2, 2018 at 11:14:31 AM PST")
        //print(dateFormatter.string(from: queryDate!))
        
        let day = TimeInterval(60*60*24) //Number of seconds in a day
        db.addMedicine(UID: 1,
                       name: "medicine1",
                       dosage: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: false,
                       reminder: false,
                       start_date: dateFri!, // same day
            end_date: nil)
        db.addMedicine(UID: 1,
                       name: "medicine2",
                       dosage: "200",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(-1), //slightly behind, should still count
            end_date: nil)
        db.addMedicine(UID: 1,
                       name: "medicine3",
                       dosage: "300",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(1), //slightly ahead, should still count, as long as it starts on the same day
            end_date: nil)
        db.addMedicine(UID: 1,
                       name: "medicine4",
                       dosage: "400",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(day), //ahead a day, should not count
            end_date: nil)
        let friMedications = db.getMedicineDate(date: dateFri!)
        
        XCTAssert(friMedications.count as Int == 3) //Two elements
        XCTAssert(friMedications.contains { element in //medicine1 is listed
            return element.name == "medicine1"
        })
        XCTAssert(friMedications.contains { element in //medicine2 is listed
            return element.name == "medicine2"
        })
    }
    
    
    func testSelectMedicationEndDateConsiderations() {
        let dateFri = dateFormatter.date(from: "Nov 2, 2018 at 11:14:31 AM PST")
        //print(dateFormatter.string(from: queryDate!))
        
        let day = TimeInterval(60*60*24) //Number of seconds in a day
        db.addMedicine(UID: 1,
                       name: "medicine1",
                       dosage: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: false,
                       reminder: false,
                       start_date: dateFri!,
                       end_date: dateFri!) // same day
        db.addMedicine(UID: 1,
                       name: "medicine2",
                       dosage: "200",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!,
                       end_date: dateFri!.addingTimeInterval(day)) //next day
        db.addMedicine(UID: 1,
                       name: "medicine3",
                       dosage: "300",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(-day),
                       end_date: dateFri!.addingTimeInterval(-day)) //day before
        db.addMedicine(UID: 1,
                       name: "medicine4",
                       dosage: "400",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!,
                       end_date: dateFri!.addingTimeInterval(-10)) //10 seconds before
        let friMedications = db.getMedicineDate(date: dateFri!)
        
        XCTAssert(friMedications.count as Int == 1) //Two elements
        //XCTAssert(friMedications.contains { element in //medicine1 is listed
        //    return element.name == "medicine1"
        //})
        XCTAssert(friMedications.contains { element in //medicine2 is listed
            return element.name == "medicine2"
        })
        //XCTAssert(friMedications.contains { element in //medicine4 is listed
        //    return element.name == "medicine4"
        //})
    }
    
    func testUpdateMedicineEndDate() {
        db.addMedicine(UID: 1,
                       name: "medicine1",
                       dosage: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: true,
                       reminder: false,
                       start_date: Date(),
                       end_date: nil)
        db.addMedicine(UID: 1,
                       name: "medicine2",
                       dosage: "200",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: true,
                       reminder: false,
                       start_date: Date(),
                       end_date: nil)
        let medications = db.getMedicine()
        XCTAssert(medications.count as Int == 2) //Two elements

        db.updateMedicineEndDate(MIDToUpdate: medications[0].MID)
        let newMedications = db.getMedicineDate(date: Date())
        XCTAssert(newMedications.count as Int == 1) //One element, since one was removed
    }
}
