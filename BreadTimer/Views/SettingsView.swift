//
//  SettingsView.swift
//  BreadTimer
//
//  Created by Kelsey Maley on 1/1/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("BufferTime") private var bufferTime = 5
    @State private var showSheet: Bool = false
    
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
                                NavigationLink(destination: BufferView(number: $bufferTime), label: {
                                    Text("Default Bake Times")
                                })
                            }
                            

                        })

                        Section(header: Text("TROUBLESHOOTING"), content: {
                            VStack {
                                NavigationLink(destination: NotificationListView(pendingNotifications: pendingNotifications)) {
                                    Text("Show Notifications")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }.padding()}
                            
                                Button("Clear Notifications"){
                                    print(bufferTime)
                                    notify.clearNotifications()
                                }.foregroundStyle(.blue)
                        })
                        }
                        .onAppear {
                            fetchPendingNotifications()
                        }
                    .navigationBarTitle("Settings")
                }

        }
}

#Preview {
    SettingsView()
}
