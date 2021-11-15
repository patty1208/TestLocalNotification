//
//  NotificationForRepeatWeekViewController.swift
//  testLocalNotification
//
//  Created by 林佩柔 on 2021/11/9.
//

import UIKit

class NotificationForRepeatWeekViewController: UIViewController {
    
    @IBOutlet weak var specificTimeDatePicker: UIDatePicker!
    
    @IBOutlet var weekdaysSwitch: [UISwitch]! // [0]星期日,[1]星期一
    var weekdaysIsActive = Array(repeating: true, count: 7) // [0]星期日,[1]星期一
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func dateComponent(weekday: Int?) -> DateComponents {
        let date = specificTimeDatePicker.date
        let calendar = Calendar.current
        var components = calendar.dateComponents([.weekday, .hour, .minute], from: date)
        components.weekday = weekday
        return components
    }
    
    @IBAction func sentNotification(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "每週特定日重複推播特定時間"
        content.sound = .default
        
        let imageURL: URL = Bundle.main.url(forResource: "alarm-clock", withExtension: "png")!
        let attachment = try! UNNotificationAttachment(identifier: "image", url: imageURL, options: nil)
        content.attachments = [attachment]
        
        for i in 1...7 {
            if weekdaysSwitch[i-1].isOn == true {
                // 更新新的推播通知
                let trigger = UNCalendarNotificationTrigger(dateMatching:dateComponent(weekday: i), repeats: true)
                let request = UNNotificationRequest(identifier: "Notification For  Repeat Every week" + "\(i-1)", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in })
            } else {
                // 移除之前是true的推播通知
                if weekdaysIsActive[i-1] == true {
                    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["Notification For  Repeat Every week" + "\(i-1)"])
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Notification For  Repeat Every week" + "\(i-1)"])
                }
            }
            weekdaysIsActive[i-1] = weekdaysSwitch[i-1].isOn
            print(weekdaysIsActive)
            if weekdaysIsActive == Array(repeating: false, count: 7){
                let content = UNMutableNotificationContent()
                content.title = "僅推播當天特定時間"
                content.sound = .default
                let trigger = UNCalendarNotificationTrigger(dateMatching:dateComponent(weekday: nil), repeats: false)
                let request = UNNotificationRequest(identifier: "Notification For One Day", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in })
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
