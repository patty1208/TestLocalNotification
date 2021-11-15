//
//  BasicLocalNotificationViewController.swift
//  testLocalNotification
//
//  Created by 林佩柔 on 2021/11/8.
//

import UIKit

class BasicLocalNotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sentNotification(_ sender: UIButton) {
        // 推播通知內容
        let content = UNMutableNotificationContent()
        content.title = "title：Basic Notification"
        content.subtitle = "subtitle："
        content.body = "下滑圖片放大\n點擊通知連結至鬧鐘圖片來源"
//        content.badge = 1
        content.sound = UNNotificationSound.default
        
        // 設置通知的圖片
        let imageURL: URL = Bundle.main.url(forResource: "alarm-clock", withExtension: "png")!
        let attachment = try! UNNotificationAttachment(identifier: "image", url: imageURL, options: nil)
        content.attachments = [attachment]
        
        // 設置點擊通知後取得的資訊
        content.userInfo = ["link" : "https://www.flaticon.com/premium-icon/alarm-clock_3158636?term=alarm&page=1&position=16&page=1&position=16&related_id=3158636&origin=search"]
        
        // 觸發方式
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        
        // 推播通知請求
        let request = UNNotificationRequest(identifier: "Basic Notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            print("成功建立推播通知")
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
