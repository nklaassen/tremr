//
//  Name of file: MissedDataTests.swift
//  Programmers: Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-11-17: Class created
//          2018-11-21: Created basic class and tests
//          2018-11-23: Updated tests
// Known Bugs: N/A

import UIKit
import XCTest
@testable import tremr

//Class for testing Missed Data 
class MissedDataTests: XCTestCase {
    
    //Calendar for comparing dates and performing date arithmetic
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    //DateFormatter for creating specific dates
    let dateFormatter = DateFormatter()

    override func setUp() {
        super.setUp()
        //Runs before every test method
        
        //Remove all medications in database
        db.clearMissedExercises()
        
        //Setup the dateFormatter, both these lines are required to use dateFormatter
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
    }
    
    override func tearDown() {
        //Runs after every test method
        
        super.tearDown()
    }
    
    func testGetMissedExercisesForLastWeek () {
        var today = Date()
        
        for _ in 0...10 {
        db.addMissedExercise(EID : 1, date : today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        }
        
        var Exercises = db.getMissedExercisesForLastWeek()
        
        today = Date()
        
        let day1 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day2 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day3 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day4 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day5 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day6 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day7 = Calendar.current.startOfDay(for: today)
        
        for i in 0...Exercises.count-1 {
            var checkDate = Exercises[i].date
            checkDate = Calendar.current.startOfDay(for: checkDate)
            XCTAssert(checkDate == day1 || checkDate == day2 || checkDate == day3 || checkDate == day4 || checkDate == day5 || checkDate == day6 || checkDate == day7)
        }
    }
    
    func testGetMissedExercisesForLastMonth () {
        var today = Date()
        
        for _ in 0...90 {
            db.addMissedExercise(EID : 1, date : today)
            today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        }
        
        var Exercises = db.getMissedExercisesForLastMonth()
        
        today = Date()
        
        let day1 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day2 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day3 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day4 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day5 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day6 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day7 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day8 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day9 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day10 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day11 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day12 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day13 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day14 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day15 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day16 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day17 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day18 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day19 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day20 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day21 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day22 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day23 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day24 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day25 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day26 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day27 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day28 = Calendar.current.startOfDay(for: today)
        
        for i in 0...Exercises.count-1 {
            var checkDate = Exercises[i].date
            checkDate = Calendar.current.startOfDay(for: checkDate)
            XCTAssert(checkDate == day1 || checkDate == day2 || checkDate == day3 || checkDate == day4 || checkDate == day5 || checkDate == day6 || checkDate == day7 || checkDate == day8 || checkDate == day9 || checkDate == day10 || checkDate == day11 || checkDate == day12 || checkDate == day13 || checkDate == day14 || checkDate == day15 || checkDate == day16 || checkDate == day17 || checkDate == day18 || checkDate == day19 || checkDate == day20 || checkDate == day21 || checkDate == day22 || checkDate == day23 || checkDate == day24 || checkDate == day25 || checkDate == day26 || checkDate == day27 || checkDate == day28)
        }
    }
    
    func testGetMissedMedicinesForLastWeek () {
        var today = Date()
        
        for _ in 0...10 {
            db.addMissedMedicine(MID : 1, date : today)
            today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        }
        
        var Medicines = db.getMissedMedicinesForLastWeek()
        
        today = Date()
        
        let day1 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day2 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day3 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day4 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day5 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day6 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day7 = Calendar.current.startOfDay(for: today)
        
        for i in 0...Medicines.count-1 {
            var checkDate = Medicines[i].date
            checkDate = Calendar.current.startOfDay(for: checkDate)
            XCTAssert(checkDate == day1 || checkDate == day2 || checkDate == day3 || checkDate == day4 || checkDate == day5 || checkDate == day6 || checkDate == day7)
        }
    }
    
    func testGetMissedMedicinesForLastMonth () {
        var today = Date()
        
        for _ in 0...90 {
            db.addMissedMedicine(MID : 1, date : today)
            today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        }
        
        var Medicines = db.getMissedMedicinesForLastMonth()
        
        today = Date()
        
        let day1 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day2 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day3 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day4 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day5 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day6 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day7 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day8 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day9 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day10 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day11 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day12 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day13 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day14 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day15 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day16 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day17 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day18 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day19 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day20 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day21 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day22 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day23 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day24 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day25 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day26 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day27 = Calendar.current.startOfDay(for: today)
        today = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let day28 = Calendar.current.startOfDay(for: today)
        
        for i in 0...Medicines.count-1 {
            var checkDate = Medicines[i].date
            checkDate = Calendar.current.startOfDay(for: checkDate)
            XCTAssert(checkDate == day1 || checkDate == day2 || checkDate == day3 || checkDate == day4 || checkDate == day5 || checkDate == day6 || checkDate == day7 || checkDate == day8 || checkDate == day9 || checkDate == day10 || checkDate == day11 || checkDate == day12 || checkDate == day13 || checkDate == day14 || checkDate == day15 || checkDate == day16 || checkDate == day17 || checkDate == day18 || checkDate == day19 || checkDate == day20 || checkDate == day21 || checkDate == day22 || checkDate == day23 || checkDate == day24 || checkDate == day25 || checkDate == day26 || checkDate == day27 || checkDate == day28)
        }
    }
    
}
