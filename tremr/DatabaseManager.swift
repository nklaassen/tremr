//
//  Name of file: DatabaseManager.swift
//  Programmers: Nic Klaassen, Jason Fevang and Colin Chan
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
// Known Bugs:

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
            //try db.run(Tremors.drop(ifExists: true))
            
            // Create the Users table
            try db.run(Users.create(ifNotExists: true) { t in     // CREATE TABLE "Users" (
                t.column(UID, primaryKey: true)                   //     "UID" INTEGER PRIMARY KEY NOT NULL,
                t.column(email, unique: true)                     //     "email" TEXT UNIQUE NOT NULL,
                t.column(name)                                    //     "name" TEXT NOT NULL
            })                                                    // )
            
            try db.run(Medicines.drop(ifExists: true))
            try db.run(Exercises.drop(ifExists: true))
            
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
                print("date: \(tremor[self.date])")
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

    func getTremorsForLastWeek() -> Array<Tremor> {
        var tremors = Array<Tremor>()
        let startOfDay = Calendar.current.startOfDay(for: Date())
        var components = DateComponents()
        components.day = -7
        let lastWeek = Calendar.current.date(byAdding: components, to: startOfDay)!
        let tremorsForLastWeek = Tremors.filter(self.date >= lastWeek)
        do {
            for tremor in try db.prepare(tremorsForLastWeek) {
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

    //Adds a medicine to the Medicines table
    func addMedicine(UID : Int64, name : String, dosage : String, mo : Bool, tu : Bool, we : Bool, th : Bool, fr : Bool, sa : Bool, su : Bool, reminder : Bool, start_date : Date, end_date : Date?) {
        print("Trying to add medicine \(name) \(dosage)")

        //Modify start_date and end_date to be the very end of the day and very beginning of the day respectively
        let modified_start_date = calendar.startOfDay(for: start_date)
        var modified_end_date :Date? = nil
        if end_date != nil {
            modified_end_date = calendar.startOfDay(for: end_date!)
        }
        
        do {
            try db.run(Medicines.insert(self.UID <- UID,
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
            print("Inserted medicine!")
        } catch {
            print("Failed to insert medicine: \(error)")
        }
    }
    
    //Adds an exercise to the Exercises table
    func addExercise(UID : Int64, name : String, unit : String, mo : Bool, tu : Bool, we : Bool, th : Bool, fr : Bool, sa : Bool, su : Bool, reminder : Bool, start_date : Date, end_date : Date?) {
        print("Trying to add exercise \(name) \(unit)")
        
        //Modify start_date and end_date to be the very end of the day and very beginning of the day respectively
        let modified_start_date = calendar.startOfDay(for: start_date)
        var modified_end_date :Date? = nil
        if end_date != nil {
            modified_end_date = calendar.startOfDay(for: (end_date?.addingTimeInterval(60*60*24))!)
        }
        
        do {
            try db.run(Exercises.insert(self.UID <- UID,
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
            print("Inserted exercise!")
        } catch {
            print("Failed to insert exercise: \(error)")
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
    
    //Returns array of all exercises
    func getExercise() -> Array<Exercise> {
        var exercises = Array<Exercise>()
        
        do {
            for exercise in try db.prepare(Exercises) {
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
    
    //Returns array of all medicines that are scheduled for the day Date
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
            }
        } catch {
            fatalError("Query didn't execute at all")
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
            //default: //Any day
            //targetWeekDay = nil
        }
        
        var query = Exercises.filter(targetWeekDay == true) // Weekday matches weekday recorded for
        query = query.filter(start_date <= date)   // Ensure searching within valid timeframe
        query = query.filter(end_date == nil || end_date >= date)   //If end_date is assigned, then only return when within the timeframe of that medicine
        
        var exercises = Array<Exercise>()
        
        do {
            for exer in try db.prepare(query) {
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
}
