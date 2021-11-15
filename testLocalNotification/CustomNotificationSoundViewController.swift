//
//  CustomNotificationSoundViewController.swift
//  testLocalNotification
//
//  Created by 林佩柔 on 2021/11/8.
//

import UIKit
import AVFoundation
var player: AVPlayer?

class CustomNotificationSoundViewController: UIViewController {
    
    struct Sound {
        var soundFileFullName: String
        var soundFile: String
        var sounfFileExtension: String
    }
    
    let soundArray = [
        Sound(soundFileFullName: "bensound-sunny-cut.mp3", soundFile: "bensound-sunny-cut", sounfFileExtension: "mp3"),
        Sound(soundFileFullName: "bensound-clearday-cut.mp3", soundFile: "bensound-clearday-cut", sounfFileExtension: "mp3"),
        Sound(soundFileFullName: "bensound-littleidea-cut.mp3", soundFile: "bensound-littleidea-cut", sounfFileExtension: "mp3"),
        Sound(soundFileFullName: "bensound-onceagain-cut.mp3", soundFile: "bensound-onceagain-cut", sounfFileExtension: "mp3"),
        Sound(soundFileFullName: "bensound-ukulele-cut.mp3", soundFile: "bensound-ukulele-cut", sounfFileExtension: "mp3"),
        Sound(soundFileFullName: "mixkit-tick-tock-clock-timer-1045.wav",soundFile: "mixkit-tick-tock-clock-timer-1045", sounfFileExtension: "wav")]
    
    var selectedSound: Sound = Sound(soundFileFullName: "bensound-sunny-cut.mp3", soundFile: "bensound-sunny-cut", sounfFileExtension: "mp3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    @IBAction func sentNotification(_ sender: UIButton) {
        player?.pause()
        
        // 推播通知內容
        let content = UNMutableNotificationContent()
        content.title = "自訂音效"
        
        // 自訂音效
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: selectedSound.soundFileFullName))
        
        // 設置通知的圖片
        let imageURL: URL = Bundle.main.url(forResource: "alarm-clock", withExtension: "png")!
        let attachment = try! UNNotificationAttachment(identifier: "image", url: imageURL, options: nil)
        content.attachments = [attachment]
        
        // 觸發方式
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        
        // 推播通知請求
        let request = UNNotificationRequest(identifier: "Custom Notification Sound", content: content, trigger: trigger)
        
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

extension CustomNotificationSoundViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        soundArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        soundArray[row].soundFile
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let url = Bundle.main.url(forResource: soundArray[row].soundFile, withExtension: soundArray[row].sounfFileExtension){
            player = AVPlayer(url: url)
            player?.play()
        }
        selectedSound = soundArray[row]
    }
    
}
