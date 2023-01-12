//
//  TaskDM.swift
//  Task_Managment
//
//  Created by Ali on 07/01/23.
//
import SwiftyJSON
struct TaskDM {
    var title: String
    var definition: String
    var time: Int
    var priority: String
    
    init(json:JSON) {
        self.title = json["title"].stringValue
        self.definition = json["description"].stringValue
        self.time = json["startTime"].intValue
        self.priority = json["status"].stringValue
    }
}


