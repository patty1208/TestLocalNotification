//
//  NotificationByTimeIntervalTriggerViewController.swift
//  testLocalNotification
//
//  Created by 林佩柔 on 2021/11/8.
//

import UIKit

class NotificationByTimeIntervalTriggerViewController: UIViewController {
    
    
    @IBOutlet weak var countdownDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sentNotification(_ sender: UIButton) {
        // 推播通知內容
        let content = UNMutableNotificationContent()
        content.title = "倒數計時結束"
        content.sound = UNNotificationSound.default
        
        // 設置通知的圖片
        let imageURL: URL = Bundle.main.url(forResource: "alarm-clock", withExtension: "png")!
        let attachment = try! UNNotificationAttachment(identifier: "image", url: imageURL, options: nil)
        content.attachments = [attachment]
        
        // 觸發方式
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: countdownDatePicker.countDownDuration, repeats: false)
        
        // 推播通知請求
        let request = UNNotificationRequest(identifier: "Notification By TimeInterval Trigger", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            print("成功建立通知...")
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
