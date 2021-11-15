//
//  NotificationForSpecificDateViewController.swift
//  testLocalNotification
//
//  Created by 林佩柔 on 2021/11/9.
//

import UIKit

class NotificationForSpecificDateViewController: UIViewController {
    
    @IBOutlet weak var specificDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sentNotification(_ sender: UIButton) {
        // 推播通知內容
        let content = UNMutableNotificationContent()
        content.title = "特定日期時間推播通知"
        content.sound = UNNotificationSound.default
        
        // 設置通知的圖片
        let imageURL: URL = Bundle.main.url(forResource: "alarm-clock", withExtension: "png")!
        let attachment = try! UNNotificationAttachment(identifier: "image", url: imageURL, options: nil)
        content.attachments = [attachment]
        
        // 觸發方式
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.month,.day,.hour,.minute], from: specificDatePicker.date), repeats: false)
        
        // 推播通知請求
        let request = UNNotificationRequest(identifier: "Notification For Specific Date", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            
        })
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
