//
//  SettingsView.swift
//  BreadTimer
//
//  Created by Jon Doucette on 1/1/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("BufferTime") private var bufferTime = 5
    @State private var showSheet: Bool = false
    @State private var notificationClearAlert: Bool = false
    private var accentColor: Color = Color(red:250/255, green: 178/255, blue: 77/255)
    
    @State private var pendingNotifications: [UNNotificationRequest] = []
    let notify = NotificationHandler()

    
    func fetchPendingNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            DispatchQueue.main.async {
                pendingNotifications = requests
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
                    Form {
                        Section(header: Text("PREFERENCES"), content: {
                            HStack{
                                Text("Buffer Time")
                                Rectangle()
                                    .foregroundStyle(.white)
                                Text("\(bufferTime) minutes ")
                                    .foregroundStyle(.blue)
                            }.onTapGesture {
                                showSheet = true
                            }.sheet(isPresented: $showSheet){
                                BufferView(number: $bufferTime)
                                    .presentationDetents([.medium, .large])
                                    .presentationBackgroundInteraction(.automatic)
                            }

                            HStack{
                                NavigationLink(destination: DefaultPreferenceView(), label: {
                                    Text("Default Bake Times")
                                })
                            }
                            

                        })

                        Section(header: Text("TROUBLESHOOTING"), content: {
                            VStack {
                                NavigationLink(destination: NotificationListView(pendingNotifications: pendingNotifications)) {
                                    Text("Show Notifications")
                                }
                            }
                            
                                Button("Clear Notifications"){
                                    notify.clearNotifications()
                                    fetchPendingNotifications()
                                    notificationClearAlert = true
                                }.foregroundStyle(.blue)
                                .alert("Notifications Cleared",
                                                               isPresented: $notificationClearAlert, actions: {
                                                           Button("Ok"){
                                                               notificationClearAlert = false
                                                           }
                                                       }, message: {
                                                           Text("Your notifications have been cleared")
                                                       })
                        })
                    }
                        .onAppear {
                            fetchPendingNotifications()
                        }
                    .navigationBarTitle("Settings")
        }
        .navigationViewStyle(.stack)
        }
}

#Preview {
    SettingsView()
}
