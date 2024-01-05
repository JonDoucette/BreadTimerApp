//
//  ScheduleButtonView.swift
//  BreadTimer
//
//  Created by Kelsey Maley on 1/5/24.
//

import SwiftUI

struct ScheduleButtonView: View {
    @State private var showingWarningAlert: Bool = false
    @State private var showingConfirmationAlert: Bool = false
    @Binding var baker: BreadHandler
    var notify: NotificationHandler
    @State private var accentColor: Color = Color(red:250/255, green: 178/255, blue: 77/255)

    
    var body: some View {
        Button("Schedule Notifications"){
            if (baker.subtractedDate < Date()){
                print("The Estimated Start Date is in the past.")
                showingWarningAlert = true
            }
            else{
                baker.prepareNotifications(notify: notify)
                showingConfirmationAlert = true
            }
        }.alert("Notifications Scheduled",
                isPresented: $showingConfirmationAlert, actions: {
            Button("Ok"){
                showingConfirmationAlert = false
            }
        }, message: {
            Text("Your notifications have been scheduled!")
        })
        .alert("The Start Date Is In The Past", isPresented: $showingWarningAlert, actions: {
            Button("Cancel", role: .cancel){
                showingWarningAlert = false
            }
            Button("Proceed"){
                showingWarningAlert = false
                baker.prepareNotifications(notify: notify)
                showingConfirmationAlert = true
            }
        }, message: {
            Text("This will cause some notifications to be skipped if their scheduled date has already occurred.")
        })

        .foregroundStyle(.white)
        .frame(width: 200, height: 50)
        .background(accentColor)
        .cornerRadius(12)
    }
}

struct ScheduleButtonViewContainer: View {

    @State var baker = BreadHandler()
    @State var notify = NotificationHandler()
    
    var body: some View {
        ScheduleButtonView(baker: $baker, notify: notify)
    }
}

#if DEBUG
struct ScheduleButtonPreviewProvider: PreviewProvider {
    static var previews: some View {
        ScheduleButtonViewContainer()
    }
}
#endif
