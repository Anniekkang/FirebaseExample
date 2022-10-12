//
//  ViewController.swift
//  FirebaseExample
//
//  Created by 나리강 on 2022/10/05.
//

import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        Analytics.logEvent("share_image", parameters: [
//          "name":"고래밥",
//          "full_text": "나리",
//        ])
//        
//        Analytics.setDefaultEventParameters([
//          "level_name": "Caverns01",
//          "level_difficulty": 4
//        ])


    
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewController ViewWillAppear")
    }

    @IBAction func profleButtonTapped(_ sender: UIButton) {
        present(ProfileViewController(), animated: true)
    }
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(settingViewController(), animated: true)
    }
    
    @IBAction func crash(_ sender: UIButton) {
    }
}

class ProfileViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ProfileViewController ViewWillAppear")
    }

    
}

class settingViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("settingViewController ViewWillAppear")
    }

}







extension UIViewController {
    
    //프로퍼티를 만들어서 사용 가능함
    var topViewController : UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    
    //최상위 뷰컨트롤러를 판단해주는 메서드
    func topViewController(currentViewController : UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController, let selectedViewController = tabBarController.selectedViewController {
            
            return self.topViewController(currentViewController: selectedViewController)
            
        } else if let navigationController = currentViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            
            return self.topViewController(currentViewController: visibleViewController)
            
        } else if let presentedViewController = currentViewController.presentedViewController {
            
            return self.topViewController(currentViewController: presentedViewController)
            
        } else {
            return currentViewController
        }
    }
}

extension UIViewController {
    
    
    //static vs class : 
    class func swizzleMethod(){
            
        let origin = #selector(viewWillAppear)
        let change = #selector(changViewWillAppear)
        
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin), let changeMethod = class_getInstanceMethod(UIViewController.self, change) else {
            print("함수를 찾을 수 없거나 오류발생")
            return
            
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
    }
    
    
    @objc func changViewWillAppear(){
        print("Change ViewWillAppear SUCCEED")
        
    }
    
    
}

