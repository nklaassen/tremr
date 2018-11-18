//
//  ExerciseTests.swift
//  tremrTests
//
//  Created by Jason Fevang on 11/5/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import XCTest
@testable import tremr

class ExerciseTests: XCTestCase {
    //Calendar for comparing dates and performing date arithmetic
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    //DateFormatter for creating specific dates
    let dateFormatter = DateFormatter()
    
    
    //MARK: Exercise Tests
    override func setUp() {
        super.setUp()
        //Runs before every test method
        
        //Remove all Exercises in database
        db.clearExercise()
        db.clearTakenExercises()
        //db.clearMissedExercises()
        
        //Setup the dateFormatter, both these lines are required to use dateFormatter
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
    }
    
    override func tearDown() {
        //Runs after every test method
        
        super.tearDown()
    }
    
    func testAddExercise() {
        let testDate = Date()
        
        let insertedEID = db.addExercise(UID: 1,
                       name: "exercise1",
                       unit: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: true,
                       reminder: false,
                       start_date: testDate,
                       end_date: nil)
        let exercises = db.getExercise()
        
        XCTAssert(exercises[0].EID == insertedEID)
        XCTAssert(exercises.count as Int == 1)
        XCTAssert(exercises[0].name == "exercise1")
        XCTAssert(exercises[0].unit == "100")
        XCTAssert(exercises[0].mo == true)
        XCTAssert(exercises[0].tu == true)
        XCTAssert(exercises[0].we == true)
        XCTAssert(exercises[0].th == true)
        XCTAssert(exercises[0].fr == true)
        XCTAssert(exercises[0].sa == false)
        XCTAssert(exercises[0].su == true)
        XCTAssert(exercises[0].reminder == false)
        //start_date is modified in the datebase to be the very start of the day, so only check for the day component to match
        XCTAssert(calendar.compare(exercises[0].start_date, to: testDate, toGranularity: Calendar.Component.day) == ComparisonResult.orderedSame)
        //end_date is modified in the database to be the very start of the next day, so subtracting 1 second from it will be the same day as testDate
        XCTAssertNil(exercises[0].end_date)
    }
    
    func testSelectExercisesRightDayOfWeek() {
        let dateFri = dateFormatter.date(from: "Nov 2, 2018 at 11:14:31 AM PST")
        //print(dateFormatter.string(from: queryDate!))
        
        let day = TimeInterval(60*60*24) //Number of seconds in a day
        db.addExercise(UID: 1,
                       name: "exercise1",
                       unit: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(-day), // It wants me to use !, I think because queryDate could be nil, so if it is throw an exception
            end_date: nil)
        db.addExercise(UID: 1,
                       name: "exercise2",
                       unit: "200",
                       mo: true, tu: true, we: true, th: true, fr: false, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(-day),
                       end_date: nil)
        
        let allExercises = db.getExercise()
        let friExercises = db.getExerciseDate(date: dateFri!)
        
        XCTAssert(allExercises.count as Int == 2)
        XCTAssert(friExercises.count as Int == 1)
        XCTAssert(friExercises[0].name == "exercise1")
    }
    
    func testSelectExerciseStartDateConsiderations() {
        let dateFri = dateFormatter.date(from: "Nov 2, 2018 at 11:14:31 AM PST")
        //print(dateFormatter.string(from: queryDate!))
        
        let day = TimeInterval(60*60*24) //Number of seconds in a day
        db.addExercise(UID: 1,
                       name: "exercise1",
                       unit: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: false,
                       reminder: false,
                       start_date: dateFri!, // same day
            end_date: nil)
        db.addExercise(UID: 1,
                       name: "exercise2",
                       unit: "200",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(-1), //slightly behind, should still count
            end_date: nil)
        db.addExercise(UID: 1,
                       name: "exercise3",
                       unit: "300",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(1), //slightly ahead, should still count, as long as it starts on the same day
            end_date: nil)
        db.addExercise(UID: 1,
                       name: "exercise4",
                       unit: "400",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(day), //ahead a day, should not count
            end_date: nil)
        let friExercises = db.getExerciseDate(date: dateFri!)
        
        XCTAssert(friExercises.count as Int == 3) //Two elements
        XCTAssert(friExercises.contains { element in //exercise1 is listed
            return element.name == "exercise1"
        })
        XCTAssert(friExercises.contains { element in //exercise2 is listed
            return element.name == "exercise2"
        })
    }
    
    
    func testSelectExerciseEndDateConsiderations() {
        let dateFri = dateFormatter.date(from: "Nov 2, 2018 at 11:14:31 AM PST")
        //print(dateFormatter.string(from: queryDate!))
        
        let day = TimeInterval(60*60*24) //Number of seconds in a day
        db.addExercise(UID: 1,
                       name: "exercise1",
                       unit: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: false,
                       reminder: false,
                       start_date: dateFri!,
                       end_date: dateFri!) // same day
        db.addExercise(UID: 1,
                       name: "exercise2",
                       unit: "200",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!,
                       end_date: dateFri!.addingTimeInterval(day)) //next day
        db.addExercise(UID: 1,
                       name: "exercise3",
                       unit: "300",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!.addingTimeInterval(-day),
                       end_date: dateFri!.addingTimeInterval(-day)) //day before
        db.addExercise(UID: 1,
                       name: "exercise4",
                       unit: "400",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: dateFri!,
                       end_date: dateFri!.addingTimeInterval(-10)) //10 seconds before
        let friExercises = db.getExerciseDate(date: dateFri!)
        
        XCTAssert(friExercises.count as Int == 1) //Two elements
        XCTAssert(friExercises.contains { element in //exercise2 is listed
            return element.name == "exercise2"
        })
    }
    
    func testUpdateExerciseEndDate() {
        db.addExercise(UID: 1,
                       name: "exercise1",
                       unit: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: true,
                       reminder: false,
                       start_date: Date(),
                       end_date: nil)
        db.addExercise(UID: 1,
                       name: "exercise2",
                       unit: "200",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: true,
                       reminder: false,
                       start_date: Date(),
                       end_date: nil)
        let exercises = db.getExercise()
        XCTAssert(exercises.count as Int == 2) //Two elements
        
        db.updateExerciseEndDate(EIDToUpdate: exercises[0].EID)
        let newExercises = db.getExerciseDate(date: Date())
        XCTAssert(newExercises.count as Int == 1) //One element, since one was removed
    }
    
    func testAddTakenExercise() {
        let dateFri = dateFormatter.date(from: "Nov 2, 2018 at 11:14:31 AM PST")
        let takenEid = db.addExercise(UID: 1,
                                      name: "exercise1",
                                      unit: "100",
                                      mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: true,
                                      reminder: false,
                                      start_date: Date(),
                                      end_date: nil)
        db.addTakenExercise(EID: takenEid!, date: dateFri!)
        
        let takenExercises = db.getTakenExercises(searchDate: dateFri!)
        XCTAssert(takenExercises.count as Int == 1) //One element
        XCTAssert(takenExercises[0].EID == takenEid)
        XCTAssert(takenExercises[0].date == dateFri)
    }
    
    func testSelectExerciseTakenExerciseConsiderations() {
        let dateThu = dateFormatter.date(from: "Nov 1, 2018 at 11:14:31 AM PST")
        let dateFri = dateFormatter.date(from: "Nov 2, 2018 at 11:14:31 AM PST")
        let dateSat = dateFormatter.date(from: "Nov 3, 2018 at 11:14:31 AM PST")
        let takenEid1 = db.addExercise(UID: 1,
                                       name: "exercise1",
                                       unit: "100",
                                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: true,
                                       reminder: false,
                                       start_date: dateFri!,
                                       end_date: nil)
        let takenEid2 = db.addExercise(UID: 1,
                                       name: "exercise2",
                                       unit: "200",
                                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: true,
                                       reminder: false,
                                       start_date: dateFri!,
                                       end_date: nil)
        
        db.addTakenExercise(EID: takenEid1!, date: dateFri!)
        db.addTakenExercise(EID: takenEid2!, date: dateSat!)
        db.addTakenExercise(EID: takenEid2!, date: dateThu!)
        
        let exercises = db.getExerciseDate(date: dateFri!)
        
        XCTAssert(exercises.count as Int == 1) //One element
        XCTAssert(exercises[0].EID == takenEid2)
        XCTAssert(exercises[0].name == "exercise2")
    }
}
