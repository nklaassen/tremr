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
