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
        
        Analytics.logEvent("share_image", parameters: [
          "name":"고래밥",
          "full_text": "나리",
        ])
        
        Analytics.setDefaultEventParameters([
          "level_name": "Caverns01",
          "level_difficulty": 4
        ])


    
}

    @IBAction func crash(_ sender: UIButton) {
    }
}
