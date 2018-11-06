//
//  Name of file: AppDelegate.swift
//  Programmers: Devansh Chopra, Nic Klaassen, Jason Fevang, Colin Chan, Kira Nishi-Beckingham, Leo Zhang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-22: initial build
//          2018-10-28: add database example
//          2018-10-29: add dummy data to db
// Known Bugs:

import UIKit

internal let IS_DEBUG = true

internal let Tremr = TremorController(); // Tremor Object for getting info

let db = DatabaseManager()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Database example
        /*
        db.addUser(name: "nic", email: "nic@gmail.com")
        db.addTremor(restingSeverity: 4.2, posturalSeverity: 3.6, UID: 0)
        for user in db.getUsers() {
            print("name \(user.name), email: \(user.email)")
        }
        for tremor in db.getTremors() {
            print("resting: \(tremor.restingSeverity), postural: \(tremor.posturalSeverity)")
        }
         */
        
        // Fill in some test data for medicine database
        let day = TimeInterval(60*60*24) //Number of seconds in a day
        db.addMedicine(UID: 1,
                       name: "medicine1",
                       dosage: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: Date().addingTimeInterval(day),
                       end_date: nil)
        db.addMedicine(UID: 1,
                       name: "medicine2",
                       dosage: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: Date().addingTimeInterval(-day),
                       end_date: nil)
        db.addMedicine(UID: 1,
                       name: "medicine3",
                       dosage: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: Date().addingTimeInterval(-3*day),
                       end_date: Date().addingTimeInterval(-day))
        db.addMedicine(UID: 1,
                       name: "medicine4",
                       dosage: "400",
                       mo: true, tu: true, we: true, th: false, fr: true, sa: false, su: false,
                       reminder: false,
                       start_date: Date(),
                       end_date: Date())
        
        
        db.addExercise(UID: 1,
                       name: "Exercise1",
                       unit: "100",
                       mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: true,
                       reminder: false,
                       start_date: Date(),
                       end_date: nil)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

