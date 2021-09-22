//
//  Notification.swift
//  Aniket_Patel_IOS_2
//
//  Created by Aniket Patel on 2021-08-16.
//

import Foundation
import UserNotifications
import SwiftUI

class Notification {
    
    static func generateNotification(title: String, description: String) {
        
        requestAuthorization()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = description
        
        
        let trigger2 = UNTimeIntervalNotificationTrigger(
        timeInterval: 15, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger2)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
        
    }
    
    static func requestAuthorization() {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                // Handle the error here.
                print("Error is there \(error)")
            }
            
        }
    }
    
}
