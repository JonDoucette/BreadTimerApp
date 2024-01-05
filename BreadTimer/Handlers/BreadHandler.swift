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
    var name = ""
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
        
        let startDate = subtractedDate
        let stretchAndFoldDate = calendar.date(byAdding: .minute, value: stretchTime*stretchInterval+bufferTime, to: startDate) ?? startDate //1:30PM
        let proofDate = calendar.date(byAdding: .minute, value: Int(bulkTime*60.0)+bufferTime, to: stretchAndFoldDate)!//3:30PM
        let ovenDate = calendar.date(byAdding: .minute, value: Int(proofTime*60.0)+bufferTime, to: proofDate)! //4:30
        let completionDate = selectedDate
        var noName = false
        
        if (name == ""){
            noName = true
            name = "Bread"
        }
        
        if (Date() < startDate){
            notify.sendNotification(
                date: startDate,
                type: "date",
                timeInterval: 5,
                title: "\(name) - Start Notification",
                body: "It's time to start combining your bread ingredients"
            )
        }
        if (Date() < stretchAndFoldDate){
            notify.sendNotification(
                date: stretchAndFoldDate,
                type: "date",
                timeInterval: 10,
                title: "\(name) - Stretch and Fold Time",
                body: "Reminder to now Stretch and Fold your bread and leave it to bulk ferment"
            )
        }
        if (Date() < proofDate){
            notify.sendNotification(
                date: proofDate,
                type: "date",
                timeInterval: 15,
                title: "\(name) - Shape and Proof Time",
                body: "Your bread should be finished bulk fermenting. You should now Shape and proof it"
            )
        }
        if (Date() < ovenDate){
            notify.sendNotification(
                date: ovenDate,
                type: "date",
                timeInterval: 20,
                title: "\(name) - Oven Time",
                body: "Proofing has been completed. Please place your bread in the oven."
            )
        }
        if (Date() < completionDate){
            notify.sendNotification(
                date: completionDate,
                type: "date",
                timeInterval: 25,
                title: "\(name) - Completed",
                body: "Your bread should now be ready!"
            )
        }

        if (noName){
            name = ""
            noName = false
        }
        
        
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
        stretchTime = UserDefaults.standard.integer(forKey: "StretchDefault")
        stretchInterval = UserDefaults.standard.integer(forKey: "IntervalDefault")
        bulkTime = UserDefaults.standard.double(forKey: "BulkDefault")
        proofTime = UserDefaults.standard.double(forKey: "ProofDefault")
        ovenTime = UserDefaults.standard.integer(forKey: "OvenDefault")
        name = ""
        selectedDate = Date()
        subtractedDate = Date()
    }
    
}
    
