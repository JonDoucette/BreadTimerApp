//
//  MainView.swift
//  BreadTimer
//
//  Created by Kelsey Maley on 1/1/24.
//

import SwiftUI

struct BakeView: View {
    
    @State private var baker = BreadHandler()
    @State private var pendingNotifications: [UNNotificationRequest] = []

    
    @State private var selectedDate = Date()
    @State private var subtractedDate = Date()
    @State var nothingField: Int = 0
    
    
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
                Spacer().frame(width: 60)
                Text("Bread Timer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                
            }
            BreadOptionView(baker: $baker)
            Spacer()
            HStack(){
                Text("Total Time: ").fontWeight(.bold)
                Text("\(baker.totalTime()) hours")
            }
            HStack(){
                Text("Estimated Start Time: ")
                
                Text("\(dateFormatter.string(from: baker.subtractedDate))")
                
            }
            
            
            Button("Schedule Notifications"){
                baker.prepareNotifications(notify: notify)
            }
            .foregroundStyle(.white)
            .frame(width: 200, height: 50)
            .background(accentColor)
            .cornerRadius(12)

        }.onChange(of: baker.selectedDate, {oldValue, newValue in
            if true {
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
        })
        .padding()
                .onChange(of: baker.calculateTimeToBake(), { oldValue, newValue in
                    if true {
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
                }
                ).background(Color(red:252/255, green: 235/255, blue: 157/255))
        }
    }

    
#Preview {
    BakeView()
}

