//
//  NotificationTestView.swift
//  Group6
//
//  Created by Luigi Verolla on 17/02/22.
//

import SwiftUI

struct NotificationTestView: View
{
    @ObservedObject private var notificationManager = NotificationManager()
    
    var body: some View {
        if notificationManager.notificationType == "test" {
            NotificationTestTargetView()
        }
        else {
            Button(action: {
                withAnimation {
                    // test notification: triggers after 5 seconds
                  //  self.notificationManager.sendNotification(title: "Hurray!", subtitle: "Nice one!", body: "If you see this text, launching the local notification worked!", launchIn: 5)
                }
            }) {
                Text("Launch Local Notification 🚀")
                    .font(.title)
            }
        }
    }
}

struct NotificationTestView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationTestView()
    }
}
