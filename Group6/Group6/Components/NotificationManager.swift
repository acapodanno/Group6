import Foundation
import SwiftUI
import UserNotifications

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate
{
    var notifications = [Notification]()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    @Published var notificationType : String = ""
    
    override init()
    {
        super.init()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
        {
            granted, error in
            
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void)
    {
        
        let userInfo = response.notification.request.content.userInfo
        if let customData = userInfo["type"] as? String
        {
            print("Custom data received: \(customData)")
            notificationType = customData
        }

        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
           willPresent notification: UNNotification,
           withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.banner, .list, .badge, .sound])
    }
    
    func sendTestNotification(title: String, subtitle: String, body: String, launchIn: Double)
    {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.userInfo["type"] = "test"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: launchIn, repeats: false)
                let request = UNNotificationRequest(identifier: "demoNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func sendProximityNotification(title: String, subtitle: String, body: String, launchIn: Double)
    {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.userInfo["type"] = "proximity"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: launchIn, repeats: false)
                let request = UNNotificationRequest(identifier: "demoNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
