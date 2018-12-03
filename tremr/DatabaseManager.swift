//
//  Name of file: DatabaseManager.swift
//  Programmers: Nic Klaassen, Jason Fevang, Colin Chan and Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20: Create database
//          2018-10-23: Schema update
//          2018-10-24: Don't use users for v1
//          2018-10-25: add medication/exercises
//          2018-11-04: filter tremors by date
//          2018-11-12: added get functions
// Known Bugs:

import Foundation

import SQLite
import Alamofire

class DatabaseManager
{
    var db : Connection! // The actual SQLite database connection
    
    // These are "Expressions" which need to be passed to many of the database calls
    
    let Users = Table("Users")
    let UID = Expression<Int64>("UID")
    let email = Expression<String>("email")
    let name = Expression<String>("name")
    let password = Expression<String>("password")
    let lastOpened = Expression<Date>("lastOpened")//Last time the app was opened
    
    let Tremors = Table("Tremors")
    let TID = Expression<Int64>("TID")
    let posturalSeverity = Expression<Int>("posturalSeverity")
    let restingSeverity = Expression<Int>("restingSeverity")
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
    
    let Exercises = Table("Exercise")
    let EID = Expression<Int64>("EID")
    // let name = Expression<String>("name") We'll use the one defined in Users table
    let unit = Expression<String>("unit")
    // We'll use the one defined in Medicines table
    /* let monday = Expression<Bool>("monday")
    let tuesday = Expression<Bool>("tuesday")
    let wednesday = Expression<Bool>("wednesday")
    let thursday = Expression<Bool>("thursday")
    let friday = Expression<Bool>("friday")
    let saturday = Expression<Bool>("saturday")
    let sunday = Expression<Bool>("sunday")
    let reminder = Expression<Bool>("reminder")
    let start_date = Expression<Date>("start_date")
    let end_date = Expression<Date?>("end_date") //optional */
    
    let MissedExercises = Table("MissedExercises")
    //EID
    //date
    
    let MissedMedicines = Table("MissedMedicines")
    //MID
    //date
    
    let TakenExercises = Table("TakenExercises")
    //EID
    //date
    
    let TakenMedicines = Table("TakenMedicines")
    //MID
    //date
    
    //Calendar for comparing dates and performing date arithmetic
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
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
            try db.run(Tremors.drop(ifExists: true))
            
            // Create the Users table
            try db.run(Users.create(ifNotExists: true) { t in     // CREATE TABLE "Users" (
                t.column(UID, primaryKey: true)                   //     "UID" INTEGER PRIMARY KEY NOT NULL,
                t.column(email, unique: true)                     //     "email" TEXT UNIQUE NOT NULL,
                t.column(name)                                    //     "name" TEXT NOT NULL
                t.column(lastOpened)
            })                                                    // )
            
            try db.run(Medicines.drop(ifExists: true))
            try db.run(Exercises.drop(ifExists: true))
            try db.run(TakenMedicines.drop(ifExists: true))

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
            
            // Create the Exercise table
            try db.run(Exercises.create(ifNotExists: true) { t in
                t.column(EID, primaryKey: true)
                t.column(UID)
                t.column(name)
                t.column(unit)
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
                t.column(UID)                                                //     "UID" INTEGER NOT NULL,
                t.column(posturalSeverity)                                   //     "posturalSeverity" INT NOT NULL,
                t.column(restingSeverity)                                    //     "restingSeverity" INT NOT NULL,
                t.column(date)                                               //     "date" DATETIME NOT NULL
                //t.foreignKey(UID, references: Users, UID, delete: .setNull)  //     FOREIGN KEY("UID") REFERENCES "Users"("UID") ON DELETE SET NULL,
            })                                                               // )
            
            // Create MissedExercises table
            try db.run(MissedExercises.create(ifNotExists: true) { t in
                t.column(EID)
                t.column(date)
                t.foreignKey(EID, references: Exercises, EID, delete: .cascade)
                t.primaryKey(EID, date)
            })
            
            // Create MissedMedicines table
            try db.run(MissedMedicines.create(ifNotExists: true) { t in
                t.column(MID)
                t.column(date)
                t.foreignKey(MID, references: Medicines, MID, delete: .cascade)
                t.primaryKey(MID, date)
            })                                                              // )
            
            // Create TakenExercises table
            try db.run(TakenExercises.create(ifNotExists: true) { t in
                t.column(EID)
                t.column(date)
                t.foreignKey(EID, references: Exercises, EID, delete: .cascade)
                t.primaryKey(EID, date)
            })
            
            // Create TakenMedicines table
            try db.run(TakenMedicines.create(ifNotExists: true) { t in
                t.column(MID)
                t.column(date)
                t.foreignKey(MID, references: Medicines, MID, delete: .cascade)
                t.primaryKey(MID, date)
            })
            
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

    // adds tremor recording to the db. Date defaults to the current date/time.
    // Note: will delete all recordings in the db from the same day as the recording being inserted
    func addTremor(restingSeverity : Double, posturalSeverity : Double, date : Date = Date()) {
        print("Trying to add tremor \(restingSeverity) \(posturalSeverity)")

        let startOfDay = Calendar.current.startOfDay(for: date)
        var components = DateComponents()
        components.day = 1
        components.second = -1
        let endOfDay = Calendar.current.date(byAdding: components, to: startOfDay)!
        let tremorsForToday = Tremors.filter(self.date >= startOfDay && self.date <= endOfDay)

        do {
            try db.run(tremorsForToday.delete()) // only one measurement allowed per day
            try db.run(Tremors.insert(self.restingSeverity <- Int(restingSeverity * 10),
                                      self.posturalSeverity <- Int(posturalSeverity * 10),
                                      self.date <- date))
            print("Inserted tremor!")
        } catch {
            print("Failed to insert tremor: \(error)")
        }
    }
    
    func addTremorAsync(restingSeverity : Double, posturalSeverity : Double, completion : @escaping (Bool)->()) {
        print("Trying to add tremor \(restingSeverity) \(posturalSeverity)")
        
        let token = UserDefaults.standard.string(forKey: authTokenKey)!
        let headers : HTTPHeaders = ["Authorization": token]
        
        let parameters : [String: Any] = [
            "resting" : Int(restingSeverity * 10),
            "postural" : Int(posturalSeverity * 10)
        ]
        
        Alamofire.request(baseUrl + "tremors", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString() { response in
            let statusCode = response.response?.statusCode
            if statusCode == 200 {
                print("adding tremor Successful")
                completion(true)
            } else {
                let responseString = response.result.value
                if responseString != nil {
                    let responseString = responseString!
                    print(responseString)
                }
                completion(false)
            }
        }
    }
    
    // Returns all tremor recording values from the db
    func getTremors() -> Array<Tremor> {
        return Array<Tremor>()
    }
    
    func getTremorsAsync(completion: @escaping ([Tremor]) -> ()) {
        Alamofire.request(baseUrl + "tremors").validate().responseData { response in
            switch response.result {
            case .success:
                print("got valid response")
                if let data = response.result.value {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    if let tremors = try? decoder.decode([Tremor].self, from: data) {
                        completion(tremors)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Returns all missed exercise values from the db
    func getMissedExercises() -> Array<MissedExercise> {
        var exercises = Array<MissedExercise>()
        do {
            for exercise in try db.prepare(MissedExercises) {
                print("date: \(exercise[self.date])")
                exercises.append(MissedExercise(EID: exercise[self.EID], date: exercise[self.date]))
            }
        } catch {
            print(error)
        }
        return exercises
    }
    
    // Returns all missed exercise values from the db
    func getMissedMedicines() -> Array<MissedMedicine> {
        var medicines = Array<MissedMedicine>()
        do {
            for medicine in try db.prepare(MissedMedicines) {
                print("date: \(medicine[self.date])")
                medicines.append(MissedMedicine(MID: medicine[self.MID], date: medicine[self.date]))
            }
        } catch {
            print(error)
        }
        return medicines
    }

    func getTremorsForLastWeek() -> [Tremor] {
        return Array<Tremor>()
    }
    
    
    // Description: Retrieve all tremor data from the past week from the database and return in a callback
    // Pre-condition: Connection to remote webserver, valid callback function prepared to recieve callback data
    // Post-condition: Tremor data passed to input callback function
    func getTremorsForLastWeekAsync(completion: @escaping ([Tremor]) -> ()) {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        var components = DateComponents()
        components.day = -6
        let lastWeek = Calendar.current.date(byAdding: components, to: startOfDay)!
        let datestring = ISO8601DateFormatter().string(from: lastWeek)
        let url = baseUrl + "tremors?since=" + datestring
        print(url)
        
        //Retrive jwt for authentication
        let jwt = UserDefaults.standard.string(forKey: authTokenKey)
        
        let Auth_header: HTTPHeaders = [ "Authorization": jwt! ]
        // Request data from the webserver using Alamofire
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Auth_header).validate().responseData { response in
            //Ensure valid response before passing data to completion callback
            switch response.result {
            case .success:
                print("got valid response")
                if let data = response.result.value {
                    //Use JSONDecoder to convert JSON data from webserver into an array of Tremor objects
                    if let tremors = try? JSONDecoder().decode([Tremor].self, from: data) {
                        //Pass Tremor array to callback completion
                        completion(tremors)
                    }
                }
            //Data request failure
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // returns only the missed exercises from the past week
    func getMissedExercisesForLastWeek() -> Array<MissedExercise> {
        var missedExercises = Array<MissedExercise>()
        let startOfDay = Calendar.current.startOfDay(for: Date())
        var components = DateComponents()
        components.day = -6
        let lastWeek = Calendar.current.date(byAdding: components, to: startOfDay)!
        let missedExercisesForLastWeek = MissedExercises.filter(self.date >= lastWeek).order(self.date.asc)
        do {
            for exercise in try db.prepare(missedExercisesForLastWeek) {
                missedExercises.append(MissedExercise(EID: exercise[self.EID], date: exercise[self.date]))
                print("Missed Exercise: ", exercise[self.date])
            }
        } catch {
            print(error)
        }
        return missedExercises
    }
    
    // returns only the missed medicines from the past week
    func getMissedMedicinesForLastWeek() -> Array<MissedMedicine> {
        var missedMedicines = Array<MissedMedicine>()
        let startOfDay = Calendar.current.startOfDay(for: Date())
        var components = DateComponents()
        components.day = -6
        let lastWeek = Calendar.current.date(byAdding: components, to: startOfDay)!
        let missedExercisesForLastWeek = MissedMedicines.filter(self.date >= lastWeek).order(self.date.asc)
        do {
            for medicine in try db.prepare(missedExercisesForLastWeek) {
                missedMedicines.append(MissedMedicine(MID: medicine[self.MID], date: medicine[self.date]))
                print("Missed Medicine: ", medicine[self.date])
            }
        } catch {
            print(error)
        }
        return missedMedicines
    }
    
    // returns only the tremor recordings from the past month
    func getTremorsForLastMonth() -> Array<Tremor> {
        var tremors = Array<Tremor>()
        let startOfDay = Calendar.current.startOfDay(for: Date())
        var components = DateComponents()
        components.day = -27
        let lastMonth = Calendar.current.date(byAdding: components, to: startOfDay)!
        let tremorsForLastMonth = Tremors.filter(self.date >= lastMonth).order(self.date.asc)
        do {
            for tremor in try db.prepare(tremorsForLastMonth) {
                tremors.append(
                    Tremor(
                        TID: tremor[self.TID],
                        UID: tremor[self.UID],
                        posturalSeverity: Double(tremor[self.posturalSeverity]) / 10.0,
                        restingSeverity: Double(tremor[self.restingSeverity]) / 10.0,
                        date: tremor[self.date]))
                print("tremor date ", tremor[self.date])
            }
        } catch {
            print(error)
        }
        return tremors
    }
    
    // returns only the exercises from the past week
    func getMissedExercisesForLastMonth() -> Array<MissedExercise> {
        var missedExercises = Array<MissedExercise>()
        let startOfDay = Calendar.current.startOfDay(for: Date())
        var components = DateComponents()
        components.day = -27
        let lastWeek = Calendar.current.date(byAdding: components, to: startOfDay)!
        let missedExercisesForLastWeek = MissedExercises.filter(self.date >= lastWeek).order(self.date.asc)
        do {
            for exercise in try db.prepare(missedExercisesForLastWeek) {
                missedExercises.append(MissedExercise(EID: exercise[self.EID], date: exercise[self.date]))
            }
        } catch {
            print(error)
        }
        return missedExercises
    }
    
    // returns only the missed medicines from the past month
    func getMissedMedicinesForLastMonth() -> Array<MissedMedicine> {
        var missedMedicines = Array<MissedMedicine>()
        let startOfDay = Calendar.current.startOfDay(for: Date())
        var components = DateComponents()
        components.day = -27
        let lastWeek = Calendar.current.date(byAdding: components, to: startOfDay)!
        let missedExercisesForLastWeek = MissedMedicines.filter(self.date >= lastWeek).order(self.date.asc)
        do {
            for medicine in try db.prepare(missedExercisesForLastWeek) {
                missedMedicines.append(MissedMedicine(MID: medicine[self.MID], date: medicine[self.date]))
                print("Missed Medicine Month: ", medicine[self.date])
            }
        } catch {
            print(error)
        }
        return missedMedicines
    }

    //Adds a medicine to the Medicines table
    func addMedicine(UID : Int64, name : String, dosage : String, mo : Bool, tu : Bool, we : Bool, th : Bool, fr : Bool, sa : Bool, su : Bool, reminder : Bool, start_date : Date, end_date : Date?) -> Int64? {
        print("Trying to add medicine \(name) \(dosage)")

        //Modify start_date and end_date to be the very end of the day and very beginning of the day respectively
        let modified_start_date = calendar.startOfDay(for: start_date)
        var modified_end_date :Date? = nil
        if end_date != nil {
            modified_end_date = calendar.startOfDay(for: end_date!)
        }
        
        do {
            //Insert medicine and return the id created by the database
            return try db.run(Medicines.insert(self.UID <- UID,
                                      self.name <- name,
                                      self.dosage <- dosage,
                                      self.monday <- mo,
                                      self.tuesday <- tu,
                                      self.wednesday <- we,
                                      self.thursday <- th,
                                      self.friday <- fr,
                                      self.saturday <- sa,
                                      self.sunday <- su,
                                      self.reminder <- reminder,
                                      self.start_date <- modified_start_date,
                                      self.end_date <- modified_end_date ))
        } catch {
            print("Failed to insert medicine: \(error)")
            //If the insert fails, return nil for the inserted MID
            return nil
        }
    }
    
    //Adds an exercise to the Exercises table
    func addExercise(UID : Int64, name : String, unit : String, mo : Bool, tu : Bool, we : Bool, th : Bool, fr : Bool, sa : Bool, su : Bool, reminder : Bool, start_date : Date, end_date : Date?) -> Int64? {
        print("Trying to add exercise \(name) \(unit)")
        
        //Modify start_date and end_date to be the very end of the day and very beginning of the day respectively
        let modified_start_date = calendar.startOfDay(for: start_date)
        var modified_end_date :Date? = nil
        if end_date != nil {
            modified_end_date = calendar.startOfDay(for: end_date!)
        }

        do {
            return try db.run(Exercises.insert(self.UID <- UID,
                                        self.name <- name,
                                        self.unit <- unit,
                                        self.monday <- mo,
                                        self.tuesday <- tu,
                                        self.wednesday <- we,
                                        self.thursday <- th,
                                        self.friday <- fr,
                                        self.saturday <- sa,
                                        self.sunday <- su,
                                        self.reminder <- reminder,
                                        self.start_date <- modified_start_date,
                                        self.end_date <- modified_end_date ))
        } catch {
            print("Failed to insert exercise: \(error)")
            //If the insert fails, return nil for the inserted EID
            return nil
        }
    }

    //Returns array of all medicines
    func getMedicine() -> Array<Medicine> {
        var medicines = Array<Medicine>()
        
        let query = Medicines.filter(end_date == nil)   //Only return active medications, without an end date set

        do {
            for medicine in try db.prepare(query) {
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
    
    
    
    func getMedicineAsync(completion: @escaping ([Tremor]) -> ()) {
        Alamofire.request(baseUrl + "meds").validate().responseData { response in
            switch response.result {
            case .success:
                print("got valid response")
                if let data = response.result.value {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    if let tremors = try? decoder.decode([Tremor].self, from: data) {
                        completion(tremors)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /*
     func getTremorsAsync(completion: @escaping ([Tremor]) -> ()) {
     Alamofire.request(baseUrl + "tremors").validate().responseData { response in
     switch response.result {
     case .success:
     print("got valid response")
     if let data = response.result.value {
     let decoder = JSONDecoder()
     decoder.dateDecodingStrategy = .iso8601
     if let tremors = try? decoder.decode([Tremor].self, from: data) {
     completion(tremors)
     }
     }
     case .failure(let error):
     print(error)
     }
     }
     }
     */
    //Returns array of all exercises
    func getExercise() -> Array<Exercise> {
        var exercises = Array<Exercise>()
        
        let query = Exercises.filter(end_date == nil)   //Only return active exercises, without an end date set

        do {
            for exercise in try db.prepare(query) {
                exercises.append(Exercise(UID: exercise[self.UID],
                                          EID: exercise[self.EID],
                                          name: exercise[self.name],
                                          unit: exercise[self.unit],
                                          mo: exercise[self.monday],
                                          tu: exercise[self.tuesday],
                                          we: exercise[self.wednesday],
                                          th: exercise[self.thursday],
                                          fr: exercise[self.friday],
                                          sa: exercise[self.saturday],
                                          su: exercise[self.sunday],
                                          reminder: exercise[self.reminder],
                                          start_date: exercise[self.start_date],
                                          end_date:exercise[self.end_date]))
            }
        } catch {
            print(error)
        }
        return exercises
    }
    
    //Returns array of all medicines that are scheduled for the day Date that haven't been completed yet
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
        }
        
        //Get all taken MIDs from that day
        let takenMedicineMIDs = getTakenMedicines(searchDate: date).map { $0.MID }
        
        let query = Medicines.filter(targetWeekDay == true) // Weekday matches weekday recorded for
                            .filter(start_date <= date)   // Ensure searching within valid timeframe
                            .filter(end_date == nil || end_date >= date)   //If end_date is assigned, then only return when within the timeframe of that medicine
        
        var medicines = Array<Medicine>()
        
        do {
            for med in try db.prepare(query) {
                // Only accept medicines that haven't been taken yet that day
                if !takenMedicineMIDs.contains(med[self.MID]) {
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
                }
            }
        } catch {
            fatalError("Query didn't execute at all \(error)")
        }
        return medicines
    }
    
    //Returns array of all exercises that are scheduled for the day Date
    func getExerciseDate(date: Date) ->Array<Exercise> {
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
        }
        
        //Get all taken EIDs from that day
        let takenExerciseEIDs = getTakenExercises(searchDate: date).map { $0.EID }

        
        var query = Exercises.filter(targetWeekDay == true) // Weekday matches weekday recorded for
                            .filter(start_date <= date)   // Ensure searching within valid timeframe
                            .filter(end_date == nil || end_date >= date)   //If end_date is assigned, then only return when within the timeframe of that medicine
        
        var exercises = Array<Exercise>()
        
        do {
            for exer in try db.prepare(query) {
                // Only accept exercises that haven't been taken yet that day
                if !takenExerciseEIDs.contains(exer[self.EID]) {
                    exercises.append(Exercise(UID: exer[self.UID],
                                              EID: exer[self.EID],
                                              name: exer[self.name],
                                              unit: exer[self.unit],
                                              mo: exer[self.monday],
                                              tu: exer[self.tuesday],
                                              we: exer[self.wednesday],
                                              th: exer[self.thursday],
                                              fr: exer[self.friday],
                                              sa: exer[self.saturday],
                                              su: exer[self.sunday],
                                              reminder: exer[self.reminder],
                                              start_date: exer[self.start_date],
                                              end_date: exer[self.end_date]))
                }
            }
        } catch {
            fatalError("Query didn't execute at all")
        }
        return exercises
    }
    
    func updateMedicine(MIDToUpdate : Int64, name: String, dosage: String,mo: Bool, tu: Bool, we: Bool, th: Bool, fr: Bool, sa: Bool, su: Bool, reminder: Bool) {
        do {
            let medicineToUpdate = Medicines.filter(MID == MIDToUpdate)
            try db.run(medicineToUpdate.update(self.name <- name, self.dosage <- dosage, monday <- mo, tuesday <- tu, wednesday <- we, thursday <- th, friday <- fr, saturday <- sa, sunday <- su, self.reminder <- reminder))
        } catch {
            fatalError("Failed to update row with MID: \(MID))")
        }
    }
    
    func updateExercise(EIDToUpdate : Int64, name: String, unit: String,mo: Bool, tu: Bool, we: Bool, th: Bool, fr: Bool, sa: Bool, su: Bool, reminder: Bool) {
        do {
            let exerciseToUpdate = Exercises.filter(EID == EIDToUpdate)
            try db.run(exerciseToUpdate.update(self.name <- name, self.unit <- unit, monday <- mo, tuesday <- tu, wednesday <- we, thursday <- th, friday <- fr, saturday <- sa, sunday <- su, self.reminder <- reminder))
        } catch {
            fatalError("Failed to update row with EID: \(EID))")
        }
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
    
    // The exercise table will update EIDs equal to EIDToUpdate. Rows matching this query will
    // have their end_date updated to the current date.
    func updateExerciseEndDate(EIDToUpdate : Int64)
    {
        let currentDate = Date.init()
        
        // UPDATE "Exercises" SET end_date to the current date
        do {
            let exerciseToUpdate = Exercises.filter(EID == EIDToUpdate)
            try db.run(exerciseToUpdate.update(end_date <- currentDate))
        } catch {
            fatalError("Failed to update row with EID: \(EID) with end_date: \(String(describing: currentDate))")
        }
    }
    
    //Empty all entries from medicine table
    func clearMedicine()
    {
        do {
            try db.run(Medicines.delete())
        } catch {
            fatalError("Failed to delete Medicines table")
        }
    }
    
    //Empty all entries from exercise table
    func clearExercise()
    {
        do {
            try db.run(Exercises.delete())
        } catch {
            fatalError("Failed to delete Exercises table")
        }
    }
    
    //Empty all entries from TakenMedicines table
    func clearTakenMedicines()
    {
        do {
            try db.run(TakenMedicines.delete())
        } catch {
            fatalError("Failed to delete TakenMedicines table")
        }
    }
    
    //Empty all entries from TakenExercises table
    func clearTakenExercises()
    {
        do {
            try db.run(TakenExercises.delete())
        } catch {
            fatalError("Failed to delete TakenExercises table")
        }
    }
    
    //Empty all entries from MissedExercises table
    func clearMissedExercises()
    {
        do {
            try db.run(MissedExercises.delete())
        } catch {
            fatalError("Failed to delete MissedExercises table")
        }
    }
    
    func addMissedExercise(EID : Int64, date : Date)
    {
        do {
            try db.run(MissedExercises.insert(self.EID <- EID,
                                              self.date <- date ))
        } catch {
            print("Failed to insert exercise: \(error)")
        }
        
    }
    
    
    func addMissedMedicine(MID : Int64, date : Date)
    {
        do {
            try db.run(MissedMedicines.insert(self.MID <- MID,
                                        self.date <- date ))
        } catch {
            print("Failed to insert medicine: \(error)")
        }

    }
    
    //Empty all entries from MissedMedicines table
    func clearMissedMedicines()
    {
        do {
            try db.run(MissedMedicines.delete())
        } catch {
            fatalError("Failed to delete MissedMedicines table")
        }
    }
    
    //Add entry to taken medicine table
    func addTakenMedicine(MID : Int64, date : Date)
    {
        do {
            try db.run(TakenMedicines.insert(self.MID <- MID,
                                             self.date <- date ))
        } catch {
            print("Failed to insert medicine: \(error)")
        }
    }
    
    //Add entry to taken exercise table
    func addTakenExercise(EID : Int64, date : Date)
    {
        do {
            try db.run(TakenExercises.insert(self.EID <- EID,
                                             self.date <- date ))
        } catch {
            print("Failed to insert exercise: \(error)")
        }
    }
    
    //Returns array of all taken medicines
    func getTakenMedicines(searchDate : Date) -> Array<TakenMedicine> {
        var takenMedicines = Array<TakenMedicine>()
        let beginDay = calendar.startOfDay(for: searchDate)
        let endDay = calendar.startOfDay(for: searchDate.addingTimeInterval(60*60*24)) // Add one day's worth of seconds, then go to the first second of that day
        
        let query = TakenMedicines.filter(date >= beginDay && date <= endDay)//Only return active medications, without an end date set
        
        do {
            for takenMedicineFromDB in try db.prepare(query) {
                takenMedicines.append(TakenMedicine(
                    MID: takenMedicineFromDB[self.MID],
                    date: takenMedicineFromDB[self.date]))
            }
        } catch {
            print(error)
        }
        return takenMedicines
    }
    
    //Returns array of all taken exercises
    func getTakenExercises(searchDate : Date) -> Array<TakenExercise> {
        var takenExercises = Array<TakenExercise>()
        let beginDay = calendar.startOfDay(for: searchDate)
        let endDay = calendar.startOfDay(for: searchDate.addingTimeInterval(60*60*24)) // Add one day's worth of seconds, then go to the first second of that day
        
        let query = TakenExercises.filter(date >= beginDay && date <= endDay)//Only return active medications, without an end date set
        
        do {
            for takenExerciseFromDB in try db.prepare(query) {
                takenExercises.append(TakenExercise(
                    EID: takenExerciseFromDB[self.EID],
                    date: takenExerciseFromDB[self.date]))
            }
        } catch {
            print(error)
        }
        return takenExercises
    }
    
    //Update medicines reminder flag to a given boolean value
    func setMedReminder(Mid : Int64, setFlag : Bool){
        do {
            let medToUpdate = Medicines.filter(MID == Mid)
            try db.run(medToUpdate.update(reminder <- setFlag))
        } catch {
            fatalError("Failed to update row with MID: \(Mid) with reminder: \(String(describing: setFlag))")
        }
    }
    
    
    //Update medicines reminder flag to a given boolean value
    func setExerReminder(Eid : Int64, setFlag : Bool){
        do {
            let exerToUpdate = Exercises.filter(EID == Eid)
            try db.run(exerToUpdate.update(reminder <- setFlag))
        } catch {
            fatalError("Failed to update row with EID: \(Eid) with reminder: \(String(describing: setFlag))")
        }
    }
}
