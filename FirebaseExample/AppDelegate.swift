//
//  AppDelegate.swift
//  FirebaseExample
//
//  Created by 나리강 on 2022/10/05.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

@main


class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UIViewController.swizzleMethod() //타입메서드로 바로 호출
        
        
        
        FirebaseApp.configure()
        
        //원격 알림 시스템에 앱을 등록
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        //메세지 대리자 설정
        Messaging.messaging().delegate = self
        
        //현재 등록된 토큰 가져오기 -> 필요없는 코드
//        Messaging.messaging().token { token, error in
//          if let error = error {
//            print("Error fetching FCM registration token: \(error)")
//          } else if let token = token {
//            print("FCM registration token: \(token)")
//
//          }
//        }
//
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    //foreground에서도 알림 수신 : 로컬/푸시 동일 -> 푸시마다 설정, 화면마다 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       
        //ex Setting화면에 있다면 포그라운드 푸시 띄우지마라!

        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        if viewController is settingViewController {
            completionHandler([])//조건에 대한 제약걸기도 가능
        } else {
            
            //.banner, .list : iOS14+
            completionHandler([.badge,.sound,.banner,.list])
        }

        
    }
    
    //유저가 푸시를 클릭했을 때만 수신 확인 가능
    //ex 특정 푸시를 클릭하면 특정 상세화면으로 화면전환 >
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("사용자가 푸시를 클릭했습니다")
        
        print(response.notification.request.content.body)
        print(response.notification.request.content.userInfo)
        
        let userInfo = response.notification.request.content.userInfo
        
        if userInfo[AnyHashable("sesac")] as? String == "project" {
         print("SESAC PROJECT")
        } else {
            print("NOTHING")
        }
        
        //
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        print(viewController)
        
        if viewController is ViewController { //is as
            viewController.navigationController?.pushViewController(settingViewController(), animated: true)
            
        }
        
        if viewController is ProfileViewController {
            viewController.dismiss(animated: true)
        }
     
        if viewController is settingViewController {
            viewController.navigationController?.popViewController(animated: true)
        }
        
       
    }
}

extension AppDelegate : MessagingDelegate {
    
    //토큰 갱신 모니터링 : 토큰 정보가 언제 바뀔까?(옵션)(클릭했을때만 진행)
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      
    }

    
}
