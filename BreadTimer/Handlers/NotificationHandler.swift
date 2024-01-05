//
//  NotificationHandler.swift
//  BreadTimer
//
//  Created by Jon Doucette on 12/27/23.
//

import Foundation
import UserNotifications
import UIKit

class NotificationHandler {
    
    
    func requestPermission(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access Granted")
            } else if let error = error {
                print(error.localizedDescription)
                }
            else{
                DispatchQueue.main.async {
                    let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
                    if !isRegisteredForRemoteNotifications {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    func sendNotification(date: Date, type: String, timeInterval: Double, title: String, body: String){
        var trigger: UNNotificationTrigger?
        
        if type == "date" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        } else if type == "time" {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func getPendingNotifications(completion: @escaping ([UNNotificationRequest]) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { requests in
            completion(requests)
        }
    }
    
    func clearNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}
    
