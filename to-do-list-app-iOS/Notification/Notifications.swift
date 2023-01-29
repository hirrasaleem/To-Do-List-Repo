//
//  Notifications.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 28/01/2023.
//

import Foundation
import UIKit
class Notifications{
    
    // Register Local notification
    func createNotificaion(id: String, title: String, body: String, date: Date){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date) //log ▿ year: 2018 month: 10 day: 20 hour: 18 minute: 11 second: 0 isLeapMonth: false
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let error = error {
                
                print(error)
            }
        })
    }
        
 // remove local notification with identifier
   func remove(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
   }
        
}
