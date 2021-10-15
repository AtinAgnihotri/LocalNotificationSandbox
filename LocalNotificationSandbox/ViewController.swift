//
//  ViewController.swift
//  LocalNotificationSandbox
//
//  Created by Atin Agnihotri on 10/08/21.
//

import UserNotifications
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarButtons()
        print("App loaded")
    }
    
    func addNavBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .done, target: self, action: #selector(scheduleLocal))
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Yay!")
            } else {
                print("Nay!")
            }
        }
    }
    
    @objc func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
        
        let content = getNotificationContent()
        let trigger = getNotificationTrigger()
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
    
    func getNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Late Wake up call"
        content.body = "This is a random body for the the user notification sandbox"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "Some Random Data"]
        return content
    }
    
    func getNotificationTrigger() -> UNTimeIntervalNotificationTrigger {
        /*
        var dateComponent = DateComponents()
        dateComponent.hour = 10
        dateComponent.minute = 30
        return UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        */
        return UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    }


}

