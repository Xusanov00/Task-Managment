//
//  UserDM.swift
//  Task_Managment
//
//  Created by Chingiz Jumanov on 10/01/23.
//

import UIKit
import SwiftyJSON

struct UserDM {
    
    var _id: String
    var firstName: String
    var lastName: String
    var position: String
    var username: String
    var phoneNumber: String
    var password: String
    var language: String
    var token: String?
    var stats: StatsDM
    
    init(json: JSON) {
        
        _id = json["_id"].stringValue
        firstName = json["firstName"].stringValue
        lastName = json["lastName"].stringValue
        position = json["position"].stringValue
        username = json["username"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        password = json["password"].stringValue
        language = json["language"].stringValue
        token = json["token"].stringValue
        stats = StatsDM(json: json["stats"])
        
    }
    
    
    
    
}

struct StatsDM {
    
    var pending: Int
    var progress: Int
    var completed: Int
    var unCompleted: Int
    
    init(json: JSON) {
        pending = json["pending"].intValue
        progress = json["progress"].intValue
        completed = json["completed"].intValue
        unCompleted = json["unCompleted"].intValue
    }
    
}



