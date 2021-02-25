//
//  NotificationSettingRequestExtension.swift
//  NewsSearch
//
//  Created by karlis.stekels on 25/02/2021.
//

import UIKit
import UserNotifications

extension SearchViewController {
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            //print("User Notification settings: (settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func requestNotificationAuthorization(){
        // Request for permissions
        UNUserNotificationCenter.current()
            .requestAuthorization(
            options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                //print("Notification granted: (granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
     
}
