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
    var stretchTime = UserDefaults.standard.integer(forKey: "StretchDefault")
    var stretchInterval = UserDefaults.standard.integer(forKey: "IntervalDefault")
    var bulkTime: Double = UserDefaults.standard.double(forKey: "BulkDefault")
    var proofTime: Double = UserDefaults.standard.double(forKey: "ProofDefault")
    var ovenTime = UserDefaults.standard.integer(forKey: "OvenDefault")
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
        
        let bufferTime = UserDefaults.standard.integer(forKey: "BufferTime")
        
        let startDate = subtractedDate // 1PM
        
        let stretchAndFoldDate = calendar.date(byAdding: .minute, value: stretchTime*stretchInterval+bufferTime, to: startDate) ?? startDate //1:30PM
        let proofDate = calendar.date(byAdding: .minute, value: Int(bulkTime*60.0)+bufferTime, to: stretchAndFoldDate)!//3:30PM
        let ovenDate = calendar.date(byAdding: .minute, value: Int(proofTime*60.0)+bufferTime, to: proofDate)! //4:30
        let completionDate = selectedDate
        
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
        let bufferCount: Float = Float(3+stretchInterval)
        let totalBuffer: Float = (Float(UserDefaults.standard.integer(forKey: "BufferTime")) * bufferCount)/60.0
        return(stretchHour + bulkHour + proofHour + ovenHour + totalBuffer)
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
    
