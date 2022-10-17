//
//  Todo.swift
//  FirebaseExample
//
//  Created by 나리강 on 2022/10/13.
//

import Foundation
import RealmSwift

class Todo : Object {
    @Persisted var title : String
    @Persisted var importance : Int
    
    
    
    @Persisted(primaryKey: true) var objectId : ObjectId
    @Persisted var detail : List<DetailTodo>
    @Persisted var memo : Memo? //EmbeddedObject는 항상 Optional
    
    convenience init(title : String, importance : Int){
        self.init()
        self.title = title
        self.importance = importance
    }
}


class DetailTodo : Object {
    @Persisted var detailTitle : String
    @Persisted var favorite : Bool
    @Persisted var deadline : Date
    
    @Persisted(primaryKey: true) var objectId : ObjectId
    
    convenience init(detailTitle : String, favorite : Bool){
        self.init()
        self.detailTitle = detailTitle
        self.favorite = favorite
    }

}
//'속해있다', 별도의 table은 만들어지지 않음, Table형태가 아니기 때문에 objectId 필요없음
class Memo : EmbeddedObject {
    
    @Persisted var content : String
    @Persisted var date : Date
    
 
    
    
    
    
}
