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
    var UID : Int64
    var posturalSeverity : Double
    var restingSeverity : Double
    var date : Date
}

extension Tremor: Decodable {
    enum CodingKeys: String, CodingKey {
        case TID = "tid"
        case UID = "uid"
        case posturalSeverity = "postural"
        case restingSeverity = "resting"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        TID = try values.decode(Int64.self, forKey: .TID)
        UID = try values.decode(Int64.self, forKey: .TID)
        posturalSeverity = try values.decode(Double.self, forKey: .posturalSeverity) / 10.0
        restingSeverity = try values.decode(Double.self, forKey: .restingSeverity) / 10.0
        
        let datestring = try values.decode(String.self, forKey: .date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        date = dateFormatter.date(from: datestring) ?? ISO8601DateFormatter().date(from: datestring)!
        
    }
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
    var EID: Int64
    var date: Date
}

struct MissedMedicine {
    var MID: Int64
    var date: Date
}

struct TakenExercise {
    var EID: Int64
    var date: Date
}

struct TakenMedicine {
    var MID: Int64
    var date: Date
}
