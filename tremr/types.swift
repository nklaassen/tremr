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

struct Schedule : Decodable {
    var mo : Bool
    var tu : Bool
    var we : Bool
    var th : Bool
    var fr : Bool
    var sa : Bool
    var su : Bool
    
    init(mo: Bool, tu: Bool, we: Bool, th: Bool, fr: Bool, sa: Bool, su: Bool ) {
        self.mo = mo
        self.tu = tu
        self.we = we
        self.th = th
        self.fr = fr
        self.sa = sa
        self.su = su
    }
}

struct MedicineFromWeb {
    var UID : Int64
    var MID : Int64
    var name : String
    var dosage : String
    var schedule : Schedule
    var reminder : Bool
    var start_date : Date
    var end_date : Date?
}

extension MedicineFromWeb: Decodable {
    enum CodingKeys: String, CodingKey {
        case MID = "mid"
        case UID = "uid"
        case name = "name"
        case dosage = "dosage"
        case schedule = "schedule"
        case reminder = "reminder"
        case start_date = "startdate"
        case end_date = "enddate"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        MID = try values.decode(Int64.self, forKey: .MID)
        UID = try values.decode(Int64.self, forKey: .UID)
        name = try values.decode(String.self, forKey: .name)
        dosage = try values.decode(String.self, forKey: .dosage)
        schedule = try values.decode(Schedule.self, forKey: .schedule)
        reminder = try values.decode(Bool.self, forKey: .reminder)
        let startdatestring = try values.decode(String.self, forKey: .start_date)
        start_date = ISO8601DateFormatter().date(from: startdatestring)!
        //end date is optional, need to allow for that with String? type
        let enddatestring = try values.decode(String?.self, forKey: .end_date)
        if enddatestring == nil{
            end_date = nil
        }
        else{
            end_date = ISO8601DateFormatter().date(from: enddatestring!)
        }
    }
}

struct Medicine : Decodable {
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
    
    init(uid: Int64, mid: Int64, name: String, dosage: String, mo: Bool, tu: Bool, we: Bool, th: Bool, fr: Bool, sa: Bool, su: Bool, reminder: Bool, start_date: Date, end_date: Date?) {
        self.UID         = uid
        self.MID         = mid
        self.name        = name
        self.dosage      = dosage
        self.mo          = mo
        self.tu          = tu
        self.we          = we
        self.th          = th
        self.fr          = fr
        self.sa          = sa
        self.su          = su
        self.reminder    = reminder
        self.start_date  = start_date
        self.end_date    = end_date
    }
    
    init(from decoder: Decoder) throws {
        let medicineFromWeb = try MedicineFromWeb(from: decoder)
        
        UID = medicineFromWeb.UID
        MID = medicineFromWeb.MID
        name = medicineFromWeb.name
        dosage = medicineFromWeb.dosage
        mo = medicineFromWeb.schedule.mo
        tu = medicineFromWeb.schedule.tu
        we = medicineFromWeb.schedule.we
        th = medicineFromWeb.schedule.th
        fr = medicineFromWeb.schedule.fr
        sa = medicineFromWeb.schedule.sa
        su = medicineFromWeb.schedule.su
        reminder = medicineFromWeb.reminder
        start_date = medicineFromWeb.start_date
        end_date = medicineFromWeb.end_date
    }
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
