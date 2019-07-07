//
//  NotificationController.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 06/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class NotificationController: NSObject, UNUserNotificationCenterDelegate {
    let notificationCenter = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    func setNotification(for task: NSManagedObject) {
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                print("Error!")
            } else {
                let taskName = task.value(forKey: "name") as! String
                let taskDescription = task.value(forKey: "desc") as! String
                let date = task.value(forKey: "date") as? Date
                let content = UNMutableNotificationContent()
                
                content.title = taskName
                content.body = taskDescription
                content.sound = UNNotificationSound.default
                
                let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date!)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                
                let identifier = taskName
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                self.notificationCenter.add(request) { (error) in
                    if let error = error {
                        print("Error \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func setupPermissions() {
        notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            if !didAllow {
                print(error)
            }
        }
    }
}
