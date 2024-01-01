//
//  ContentView.swift
//  BreadTimer
//
//  Created by Jon Doucette on 12/27/23.
//

// Combine Ingredients, Fold and Shape x times every x minutes
//Bulk Fermentation
// Shaping
// Proof (second Rest)
// Preheat Oven
// Put in oven
// Take out of oven and let rest
// Completed

import SwiftUI



struct ContentView: View {
    
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
            NavigationView {
                VStack {
                    NavigationLink(destination: NotificationListView(pendingNotifications: pendingNotifications)) {
                        Text("Show Notifications")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .onAppear {
                    fetchPendingNotifications()
                }
            }
                HStack(){
                    Text("Total Time: ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(baker.totalTime()) hours")
                }
            HStack(){
                Text("Estimated Start Time: ")
                
                Text("\(dateFormatter.string(from: baker.subtractedDate))")

            }

                
                Button("Schedule Notifications"){
                    baker.prepareNotifications(notify: notify)
                }
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(accentColor)
                .cornerRadius(12)
                
                Spacer()
                Text("Not working?")
                    .foregroundColor(.gray)
                    .italic()
                Button("Request Permissions"){
                    notify.requestPermission()
                    notify.clearNotifications()
                }
            }.padding()
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
                })
                .background(Color(red:252/255, green: 235/255, blue: 157/255))

        }
    
    }

struct NotificationListView: View {
    let pendingNotifications: [UNNotificationRequest]

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var body: some View {
        List(pendingNotifications, id: \.identifier) { notification in
            VStack(alignment: .leading) {
                Text("Title: \(notification.content.title)")
                Text("Body: \(notification.content.body)")
                if let trigger = notification.trigger as? UNCalendarNotificationTrigger {
                                    let triggerDate = trigger.nextTriggerDate()
                    
                                    if let date = triggerDate {
                                        Text("Scheduled Time: \(dateFormatter.string(from: date))")
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                    }
                                }

            }
        }
        .navigationTitle("Pending Notifications")
    }
}
    
#Preview {
    ContentView()
}
