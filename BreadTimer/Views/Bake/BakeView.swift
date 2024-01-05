//
//  MainView.swift
//  BreadTimer
//
//  Created by Kelsey Maley on 1/1/24.
//

import SwiftUI

struct BakeView: View {
    
    @AppStorage("BufferTime") private var bufferTime = 0
    
    @State private var baker = BreadHandler()
    @State private var pendingNotifications: [UNNotificationRequest] = []
    
    @State private var showingWarningAlert: Bool = false
    @State private var showingConfirmationAlert: Bool = false
    
    @State private var accentColor: Color = Color(red:250/255, green: 178/255, blue: 77/255)
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()

    func fetchPendingNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            DispatchQueue.main.async {
                self.pendingNotifications = requests
            }
        }
    }
    
    func recalculateTotalTime(){
        let calendar = Calendar.current
        let bakeTime = baker.calculateTimeToBake()
        
        let integerHours = Int(bakeTime)
        let fractionalHours = bakeTime - Float(integerHours)
        let minutes = Int(fractionalHours * 60)
        
        var dateComponents = DateComponents()
        dateComponents.hour = -integerHours
        dateComponents.minute = -minutes
        
        let newDate = calendar.date(byAdding: dateComponents, to: baker.selectedDate)
        baker.subtractedDate = newDate ?? Date()
    }
    
    let notify = NotificationHandler()
    
    
    var body: some View {
        VStack(spacing: 20){
            HStack(){
                Button(action: {
                    baker.resetToDefaults()
                }, label: {
                    Image(systemName: "gobackward")
                        .font(.system(size: 20))
                })
                Spacer().frame(width: 70)

                Spacer()
            }.overlay(Text("Bread Timer")
                .font(.largeTitle)
                .fontWeight(.bold), alignment: .top)
            
            
            BreadOptionView(baker: $baker)
                .ignoresSafeArea()
            Spacer()
            HStack(){
                Text("Total Time: ").fontWeight(.bold)
                Text("\(baker.totalTime()) hours")
            }
            HStack(){
                Text("Estimated Start Time: ")
                
                Text("\(dateFormatter.string(from: baker.subtractedDate))")
                
            }
            
            ScheduleButtonView(baker: $baker, notify: notify)

        }

        .onChange(of: baker.selectedDate, {oldValue, newValue in
            recalculateTotalTime()
        })
        .padding()
                .onChange(of: baker.calculateTimeToBake(), { oldValue, newValue in
                    recalculateTotalTime()
                }
                ).background(Color(red:252/255, green: 235/255, blue: 157/255))
            .onChange(of: bufferTime, {oldValue, newValue in recalculateTotalTime()})
    }
    }

    
#Preview {
    BakeView()
}

