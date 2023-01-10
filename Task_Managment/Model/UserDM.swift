//
//  UserDM.swift
//  Task_Managment
//
//  Created by Chingiz Jumanov on 10/01/23.
//

import UIKit
import SwiftyJSON

struct UserDM {
    
    var fullName: String
    var position: String
    var username: String
    var phoneNumber: String
    var password: String
    var language: String
    var stats: StatsDM
    
    init(json: JSON) {
        fullName = json["fullName"].stringValue
        position = json["position"].stringValue
        username = json["username"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        password = json["password"].stringValue
        language = json["language"].stringValue
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
