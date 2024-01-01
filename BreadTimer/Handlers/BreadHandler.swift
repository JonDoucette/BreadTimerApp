//
//  BreadHandler.swift
//  BreadTimer
//
//  Created by Jon Doucette on 12/29/23.
//

import Foundation
import Observation

@Observable
class BreadHandler {
    
    //Times
    var stretchTime = 30
    var stretchInterval = 1
    var bulkTime = 12
    var proofTime = 24
    var ovenTime = 45
    var selectedDate = Date()
    var subtractedDate = Date()
    
    func printValues(){
        print("Stretch Time: \(stretchTime)")
        print("Stretch Interval: \(stretchInterval)")
        print("Bulk Time: \(bulkTime)")
        print("Proof Time: \(proofTime)")
        print("Oven Time: \(ovenTime)")
        print("Selected Date: \(selectedDate)")
        print("Subtracted Date: \(subtractedDate)")
    }
    func prepareNotifications(notify: NotificationHandler){
        notify.requestPermission()
        print("Permission Requested")
        
        let calendar = Calendar.current
        
        let startDate = subtractedDate // 1PM
        
        let stretchAndFoldDate = calendar.date(byAdding: .minute, value: stretchTime*stretchInterval, to: startDate) ?? startDate //1:30PM
        let proofDate = calendar.date(byAdding: .minute, value: bulkTime*60, to: stretchAndFoldDate)!//3:30PM
        let ovenDate = calendar.date(byAdding: .minute, value: proofTime*60, to: proofDate)! //4:30
        let completionDate = selectedDate
        
        print(startDate)
        print(stretchAndFoldDate)
        print(proofDate)
        print(ovenDate)
        print(completionDate)
        
        notify.sendNotification(
            date: startDate,
            type: "time",
            timeInterval: 5,
            title: "Baker Notification TIME",
            body: "It's time to start combining your bread ingredients"
        )
        notify.sendNotification(
            date: startDate,
            type: "date",
            timeInterval: 5,
            title: "Baker Notification DATE",
            body: "It's time to start combining your bread ingredients"
        )
        notify.sendNotification(
            date: stretchAndFoldDate,
            type: "date",
            timeInterval: 10,
            title: "Bread Stretch and Fold Time",
            body: "Reminder to now Stretch and Fold your bread and leave it to bulk ferment"
        )
        notify.sendNotification(
            date: proofDate,
            type: "date",
            timeInterval: 15,
            title: "Bread Shape and Proof Time",
            body: "Your bread should be finished bulk fermenting. You should now Shape and proof it"
        )
        notify.sendNotification(
            date: ovenDate,
            type: "date",
            timeInterval: 20,
            title: "Bread Oven Time",
            body: "Proofing has been completed. Please place your bread in the oven."
        )
        notify.sendNotification(
            date: completionDate,
            type: "date",
            timeInterval: 25,
            title: "Bread Completed",
            body: "Your bread should now be ready!"
        )
        
        
        print("Notifications Queued")
    }
    
    func totalTime() -> String{
        let total = calculateTimeToBake()
        return String(format: "%.2f", total)
    }
    
    func calculateTimeToBake() -> Float{
        let stretchHour: Float = (Float(stretchTime) * Float(stretchInterval))/60.0
        let bulkHour: Float = Float(bulkTime)
        let proofHour: Float = Float(proofTime)
        let ovenHour: Float = Float(ovenTime)/60.0
        return(stretchHour + bulkHour + proofHour + ovenHour)
    }
    
    func resetToDefaults(){
        stretchTime = 30
        stretchInterval = 1
        bulkTime = 12
        proofTime = 24
        ovenTime = 45
        selectedDate = Date()
        subtractedDate = Date()
    }
    
}
    
