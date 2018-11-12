//
//  Name of file: Types.swift
//  Programmers: Nic Klaassen and Jason Fevang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-28: created file
//          2018-10-30: add medicine and exercise
//          2018-10-31: renames
// Known Bugs:

import Foundation



struct User {
    var UID : Int64
    var email : String
    var name : String
}

struct Tremor {
    var TID : Int64
    //var UID : Int64
    var posturalSeverity : Double
    var restingSeverity : Double
    var completed : Bool
    var date : Date
}

struct Medicine {
    var UID : Int64
    var MID : Int64
    var name : String
    var dosage : String
    var mo : Bool
    var tu : Bool
    var we : Bool
    var th : Bool
    var fr : Bool
    var sa : Bool
    var su : Bool
    var reminder : Bool
    var start_date : Date
    var end_date : Date?
}

struct Exercise {
    var UID : Int64
    var EID : Int64
    var name : String
    var unit : String
    var mo : Bool
    var tu : Bool
    var we : Bool
    var th : Bool
    var fr : Bool
    var sa : Bool
    var su : Bool
    var reminder : Bool
    var start_date : Date
    var end_date : Date?
}

struct MissedExercise {
    var UID: Int64
    var EID: Int64
    var date: Date
}

struct MissedMedicine {
    var UID: Int64
    var MID: Int64
    var date: Date
}

struct TakenExercise {
    var UID: Int64
    var EID: Int64
    var date: Date
}

struct TakenMedicine {
    var UID: Int64
    var MID: Int64
    var date: Date
}
