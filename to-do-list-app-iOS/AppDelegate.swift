//
//  AppDelegate.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 27/01/2023.
//

import AdSupport
import Firebase
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore
import UIKit
import UserNotifications
import AppTrackingTransparency
@main
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate{

    var window: UIWindow?

    // TODO: Make buttons (shapes and transparent) dynamically adjust for Accessibility just like labels (which have IB property)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Initialize Firebase
        FirebaseApp.configure()
        //Register notification
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        application.beginBackgroundTask(withName: "showNotification", expirationHandler: nil)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if let error = error {
                debugPrint("Error: \(error)")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 15.0, *) {
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                        
                    })
                }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


class NotificationHandler{
//Permission function
func askNotificationPermission(completion: @escaping ()->Void){
    
    //Permission to send notifications
    let center = UNUserNotificationCenter.current()
    // Request permission to display alerts and play sounds.
    center.requestAuthorization(options: [.alert, .badge, .sound])
    { (granted, error) in
        // Enable or disable features based on authorization.
        completion()
    }
}
}
