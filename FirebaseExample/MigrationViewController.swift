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
        
        //4. DetailTodo
        for i in 1...10 {
            let task = DetailTodo(detailTitle: "양파\(i)", favorite: true)
            
            try! localRealm.write {
                localRealm.add(task)
            }
        }
        
        
        
        //특정 Todo table에 DetailToDo추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 7'").first else { return }
//        
//        let detail = DetailTodo(detailTitle: "frank", favorite: false)
//
//        try! localRealm.write {
//            task.detail.append(detail)
//        }
//
//
//
//
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 3'").first else { return }
//
//        let detail2 = DetailTodo(detailTitle: "아이스크림\(Int.random(in: 1...5))", favorite: false)
//        for _ in 1...10 {
//            try! localRealm.write {
//                task.detail.append(detail)
//            }
//        }
//        //특정 Todo 테이블 삭제
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 7'").first else { return }
//
//        //detail 먼저 지워주기
//        try! localRealm.write({
//            localRealm.delete(task.detail)
//            localRealm.delete(task)
//        })
//    }
    
        //특정 Todo에 메모추가
        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 6'").first else { return }
        
        let memo = Memo()
        memo.content = "이렇게 메모 내용을 추가해봅니다"
        memo.date = Date()
        
    
        try! localRealm.write({
            task.memo = memo
        })
}

}
