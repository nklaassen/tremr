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
import UserNotifications

internal let IS_DEBUG = true

internal let Tremr = TremorController(); // Tremor Object for getting info

let db = DatabaseManager()

let baseUrl = "http://ec2-34-209-34-34.us-west-2.compute.amazonaws.com/api/"

//For authentication with web server and almofire
let authTokenKey = "authToken"

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
        
        //prompt permission for notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
                
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("resign Active")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("did Enter Background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("will enter foreground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("did become active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("will terminate")
    }


}

