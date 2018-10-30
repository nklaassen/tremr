//
//  types.swift
//  tremr
//
//  Created by nklaasse on 10/24/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import Foundation



struct User {
    var UID : Int64
    var email : String
    var name : String
}

struct Tremor {
    var TID : Int64
    var UID : Int64
    var posturalSeverity : Float
    var restingSeverity : Float
    var completed : Bool
}

// Select days of week for exercise/medication schedule
struct days_of_week {
    var Mo : Bool
    var Tu : Bool
    var We : Bool
    var Th : Bool
    var Fr : Bool
    var Sa : Bool
    var Su : Bool
}

struct Medicine {
    var UID : Int64
    var MID : Int64
    var name : String
    var dosage : String
    var frequency : String
    var reminder : Bool
    var start_date : Date
    var end_date : Date
}
