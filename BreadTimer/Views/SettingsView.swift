//
//  SettingsView.swift
//  BreadTimer
//
//  Created by Kelsey Maley on 1/1/24.
//

import SwiftUI

struct SettingsView: View {
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
            VStack {
                NavigationLink(destination: NotificationListView(pendingNotifications: pendingNotifications)) {
                    Text("Show Notifications")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }.padding()
                Button("Clear Notifications"){
                    notify.clearNotifications()
                }.foregroundStyle(.blue)
            }
            .onAppear {
                fetchPendingNotifications()
            }
        }
    }
}

#Preview {
    SettingsView()
}
