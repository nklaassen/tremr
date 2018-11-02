//
//  dbManager.swift
//  tremr
//
//  Created by nklaasse on 10/24/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import Foundation

import SQLite

class DatabaseManager
{
    var db : Connection! // The actual SQLite database connection

    // These are "Expressions" which need to be passed to many of the database calls
    
    let Users = Table("Users")
    let UID = Expression<Int64>("UID")
    let email = Expression<String>("email")
    let name = Expression<String>("name")
    let password = Expression<String>("password")

    let Tremors = Table("Tremors")
    let TID = Expression<Int64>("TID")
    let posturalSeverity = Expression<Int>("posturalSeverity")
    let restingSeverity = Expression<Int>("restingSeverity")
    let completed = Expression<Bool>("completed")
    let date = Expression<Date>("date")

    let Medicines = Table("Medicine")
    let MID = Expression<Int64>("MID")
    // let name = Expression<String>("name") We'll use the one defined in Users table
    let dosage = Expression<String>("dosage")
    let monday = Expression<Bool>("monday")
    let tuesday = Expression<Bool>("tuesday")
    let wednesday = Expression<Bool>("wednesday")
    let thursday = Expression<Bool>("thursday")
    let friday = Expression<Bool>("friday")
    let saturday = Expression<Bool>("saturday")
    let sunday = Expression<Bool>("sunday")
    let reminder = Expression<Bool>("reminder")
    let start_date = Expression<Date>("start_date")
    let end_date = Expression<Date?>("end_date") //optional


    init() {
        do {
            print("dbManager init")
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            let db = try Connection("\(path)/db.sqlite3")
            self.db = db

            // May need to uncomment these if you are debugging and changing the db schema
            //try db.run(Users.drop(ifExists: true))
            //try db.run(Tremors.drop(ifExists: true))
            
            // Create the Users table
            try db.run(Users.create(ifNotExists: true) { t in     // CREATE TABLE "Users" (
                t.column(UID, primaryKey: true)                   //     "UID" INTEGER PRIMARY KEY NOT NULL,
                t.column(email, unique: true)                     //     "email" TEXT UNIQUE NOT NULL,
                t.column(name)                                    //     "name" TEXT NOT NULL
            })                                                    // )
            
            try db.run(Medicines.drop(ifExists: true))
            
            // Create the Medicine table
            try db.run(Medicines.create(ifNotExists: true) { t in
                t.column(MID, primaryKey: true)
                t.column(UID)
                t.column(name)
                t.column(dosage)
                t.column(monday)
                t.column(tuesday)
                t.column(wednesday)
                t.column(thursday)
                t.column(friday)
                t.column(saturday)
                t.column(sunday)
                t.column(reminder)
                t.column(start_date)
                t.column(end_date)
                t.foreignKey(UID, references: Users, UID, delete: .setNull)
            })
            
            // Create the Tremors table
            try db.run(Tremors.create(ifNotExists: true) { t in              // CREATE TABLE "Tremors" (
                t.column(TID, primaryKey: true)                              //     "TID" INTEGER PRIMARY KEY NOT NULL,
                //t.column(UID)                                                //     "UID" INTEGER NOT NULL,
                t.column(posturalSeverity)                                   //     "posturalSeverity" INT NOT NULL,
                t.column(restingSeverity)                                    //     "restingSeverity" INT NOT NULL,
                t.column(completed)                                          //     "completed" BOOL NOT NULL
                t.column(date)                                               //     "date" DATETIME NOT NULL
                //t.foreignKey(UID, references: Users, UID, delete: .setNull)  //     FOREIGN KEY("UID") REFERENCES "Users"("UID") ON DELETE SET NULL,
            })                                                               // )

            // Initialize the DB with some dummy data
            if getTremors().count == 0 {
                for i in 0...365 {
                    addTremor(restingSeverity: Double(arc4random_uniform(50)) / 10.0 + 2.5,
                              posturalSeverity: Double(arc4random_uniform(50)) / 10.0 + 2.5,
                              date: Calendar.current.date(byAdding: .day, value: -1 * i, to: Date())!)
                }
            }

        } catch {
            print("Failed to init DB: \(error)")
        }
    }

    func addUser(name : String, email : String) {
        print("Trying to add user \(name) \(email)")
        do {
            try db.run(Users.insert(self.name <- name, self.email <- email))
            print("Inserted user!")
        } catch {
            print("Failed to insert user: \(error)")
        }
    }
    
    func getUsers() -> Array<User> {
        var users = Array<User>()
        do {
            for user in try db.prepare(Users) {
                users.append(User(UID: user[self.UID],
                                  email: user[self.email],
                                  name: user[self.name]))
            }
        } catch {
            print(error)
        }
        return users
    }

    func addTremor(restingSeverity : Double, posturalSeverity : Double, date : Date = Date()) {
        print("Trying to add tremor \(restingSeverity) \(posturalSeverity)")
        do {
            try db.run(Tremors.insert(self.restingSeverity <- Int(restingSeverity * 10),
                                      self.posturalSeverity <- Int(posturalSeverity * 10),
                                      self.completed <- true,
                                      self.date <- date))
            print("Inserted tremor!")
        } catch {
            print("Failed to insert tremor: \(error)")
        }
    }
    
    func getTremors() -> Array<Tremor> {
        var tremors = Array<Tremor>()
        do {
            for tremor in try db.prepare(Tremors) {
                tremors.append(Tremor(TID: tremor[self.TID],
                                      //UID: tremor[self.UID],
                                      posturalSeverity: Double(tremor[self.posturalSeverity]) / 10.0,
                                      restingSeverity: Double(tremor[self.restingSeverity]) / 10.0,
                                      completed: tremor[self.completed],
                                      date: tremor[self.date]))
            }
        } catch {
            print(error)
        }
        return tremors
    }
    
    func addMedicine(UID : Int64, name : String, dosage : String, monday : Bool, tuesday : Bool, wednesday : Bool, thursday : Bool, friday : Bool, saturday : Bool, sunday : Bool, reminder : Bool, start_date : Date, end_date : Date?) {
        print("Trying to add medicine \(name) \(dosage)")
        let query = Medicines.select(name)
        print(query)
        do {
            try db.run(Medicines.insert(self.UID <- UID,
                                      self.name <- name,
                                      self.dosage <- dosage,
                                      self.monday <- monday,
                                      self.tuesday <- tuesday,
                                      self.wednesday <- wednesday,
                                      self.thursday <- thursday,
                                      self.friday <- friday,
                                      self.saturday <- saturday,
                                      self.sunday <- sunday,
                                      self.reminder <- reminder,
                                      self.start_date <- start_date,
                                      self.end_date <- end_date ))
            print("Inserted medicine!")
        } catch {
            print("Failed to insert medicine: \(error)")
        }
    }
    
    func getMedicine() -> Array<Medicine> {
        var medicines = Array<Medicine>()
        
        do {
            for medicine in try db.prepare(Medicines) {
                medicines.append(Medicine(UID: medicine[self.UID],
                                          MID: medicine[self.MID],
                                          name: medicine[self.name],
                                          dosage: medicine[self.dosage],
                                          mo: medicine[self.monday],
                                          tu: medicine[self.tuesday],
                                          we: medicine[self.wednesday],
                                          th: medicine[self.thursday],
                                          fr: medicine[self.friday],
                                          sa: medicine[self.saturday],
                                          su: medicine[self.sunday],
                                          reminder: medicine[self.reminder],
                                          start_date: medicine[self.start_date],
                                          end_date:medicine[self.end_date]))
            }
        } catch {
            print(error)
        }
        return medicines
    }
    
    func getMedicineDate(date: Date) ->Array<Medicine> {
        //weekDay is a number. 1-sunday, 2-monday, ... 7-saturday
        let weekDay = Calendar.current.component(.weekday, from: date)

        var targetWeekDay :Expression<Bool>
        switch weekDay {
        case 1: //Sunday
            targetWeekDay = sunday
        case 2: //Monday
            targetWeekDay = monday
        case 3: //Tuesday
            targetWeekDay = tuesday
        case 4: //Wednesday
            targetWeekDay = wednesday
        case 5: //Thursday
            targetWeekDay = thursday
        case 6: //Friday
            targetWeekDay = friday
        default: //Saturday
            targetWeekDay = saturday
            //default: //Any day
            //targetWeekDay = nil
        }
        var query = Medicines.filter(targetWeekDay == true) // Weekday matches weekday recorded for
        query = query.filter(start_date <= date)   // Ensure searching within valid timeframe
        query = query.filter(end_date == nil || end_date >= date)   //If end_date is assigned, then only return when within the timeframe of that medicine
        
        var medicines = Array<Medicine>()
        
        do {
            for med in try db.prepare(query) {
                medicines.append(Medicine(UID: med[self.UID],
                                          MID: med[self.MID],
                                          name: med[self.name],
                                          dosage: med[self.dosage],
                                          mo: med[self.monday],
                                          tu: med[self.tuesday],
                                          we: med[self.wednesday],
                                          th: med[self.thursday],
                                          fr: med[self.friday],
                                          sa: med[self.saturday],
                                          su: med[self.sunday],
                                          reminder: med[self.reminder],
                                          start_date: med[self.start_date],
                                          end_date:med[self.end_date]))
                //print("name: \(try med.get(name))")
            }
        } catch {
            fatalError("Query didn't execute at all")
        }
        return medicines
    }
    
    // The medicine table will update MIDs equal to MIDToUpdate. Rows matching this query will
    // have their end_date updated to the current date.
    func updateMedicineEndDate(MIDToUpdate : Int64)
    {
        let currentDate = Date.init()
        
        // UPDATE "Medicines" SET end_date to the current date
        do {
            let medicineToUpdate = Medicines.filter(MID == MIDToUpdate)
            try db.run(medicineToUpdate.update(end_date <- currentDate))
        } catch {
            fatalError("Failed to update row with MID: \(MID) with end_date: \(String(describing: currentDate))")
        }
    }
}
