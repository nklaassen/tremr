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

struct Medicine {
    var UID : Int64
    var MID : Int64
    var name : String
    var dosage : String
    var monday : Bool
    var tuesday : Bool
    var wednesday : Bool
    var thursday : Bool
    var friday : Bool
    var saturday : Bool
    var sunday : Bool
    var reminder : Bool
    var start_date : Date
    var end_date : Date?
}
