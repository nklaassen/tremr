//
//  Name of file: NotificationFunctions.swift
//  Programmers: Leo Zhang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-11-12: initial commit
// Known Bugs:

import Foundation
import UIKit
import UserNotifications

//Create Date from picker selected value.
func createDate(weekday: Int, hour: Int, minute: Int, year: Int)->Date{
    
    var components = DateComponents()
    components.hour = hour
    components.minute = minute
    components.year = year
    components.weekday = weekday // sunday = 1 ... saturday = 7
    components.weekdayOrdinal = 10
    components.timeZone = .current
    
    let calendar = Calendar(identifier: .gregorian)
    return calendar.date(from: components)!
}

func dailyTremorRecordingReminder(at date: Date, ID: String) {
    
    let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
    
    let content = UNMutableNotificationContent()
    content.title = "Daily Tremor Reminder"
    content.body = "Remeber to record your tremors for today!"
    //content.sound = UNNotificationSound.default()
    content.categoryIdentifier = "todoList"
    
    let request = UNNotificationRequest(identifier: ID, content: content, trigger: trigger)
    
    //UNUserNotificationCenter.current().delegate = self
    //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(request) {(error) in
        if let error = error {
            print("Uh oh! We had an error: \(error)")
        }
    }
}

func scheduleMedicationNotificationWeekly(at date: Date, name: String, ID: String) {
    
    let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
    
    let content = UNMutableNotificationContent()
    content.title = "Medication Reminder"
    content.body = "Remember to take \(name) today!"
    //content.sound = UNNotificationSound.default()
    content.categoryIdentifier = "todoList"
    
    let request = UNNotificationRequest(identifier: ID, content: content, trigger: trigger)
    
    //UNUserNotificationCenter.current().delegate = self
    //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(request) {(error) in
        if let error = error {
            print("Uh oh! We had an error: \(error)")
        }
    }
}

func scheduleExerciseNotificationWeekly(at date: Date, name: String, ID: String) {
    
    let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
    
    let content = UNMutableNotificationContent()
    content.title = "Exercise Reminder"
    content.body = "Remember to do \(name) today!"
    //content.sound = UNNotificationSound.default()
    content.categoryIdentifier = "todoList"
    
    let request = UNNotificationRequest(identifier: ID, content: content, trigger: trigger)
    
    //UNUserNotificationCenter.current().delegate = self
    //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(request) {(error) in
        if let error = error {
            print("Uh oh! We had an error: \(error)")
        }
    }
}
