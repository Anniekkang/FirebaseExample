//
//  MigrationViewController.swift
//  FirebaseExample
//
//  Created by 나리강 on 2022/10/13.
//

import UIKit
import RealmSwift

class MigrationViewController: UIViewController {

    
    let localRealm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //1.fileURL
        print("fileURL : \(localRealm.configuration.fileURL!)")
        
        //2. SchemaVersion
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!)
            print("SchemaVersion : \(version)")
        } catch {
            print(error)
        }
       
       // 3. Test
        for i in 1...100 {
            let task = Todo(title: "고래밥의 할일 \(i)", importance: Int.random(in: 1...5))

            try! localRealm.write({
                localRealm.add(task)
            })
        }
    }
    

    

}
