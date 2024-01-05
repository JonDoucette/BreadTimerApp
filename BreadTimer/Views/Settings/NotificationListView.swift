//
//  NotificationListView.swift
//  BreadTimer
//
//  Created by Kelsey Maley on 1/1/24.
//

import SwiftUI

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
                Text("\(notification.content.title)")
                Text("\(notification.content.body)")
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
        .navigationTitle("Notifications")
    }
}

#Preview {
    NotificationListView(pendingNotifications: [])
}
