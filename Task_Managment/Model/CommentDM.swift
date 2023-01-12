//
//  CommentDM.swift
//  Task_Managment
//
//  Created by O'ral Nabiyev on 12/01/23.
//

import Foundation
import SwiftyJSON

struct CommentDM {
    var taskID: String
    var userId: String
    var text: String
    var isSeen: Bool
    var date: Int
    var fromAdmin: Bool
    
    init(json: JSON) {
        self.taskID = json["taskId"].stringValue
        self.userId = json["userId"].stringValue
        self.text = json["text"].stringValue
        self.isSeen = json["isSeen"].boolValue
        self.date = json["date"].intValue
        self.fromAdmin = json["fromAdmin"].boolValue
    }
    
    
}
