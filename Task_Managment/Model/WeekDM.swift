//
//  WeekDM.swift
//  Task_Managment
//
//  Created by MacBook Pro on 14/01/23.
//

import SwiftyJSON
struct WeekDM {
    var time:String
    var day:String
    var allTasks:Int
    var complated:Int
    init(json:JSON) {
        self.time = json["time"].stringValue
        self.day = json["day"].stringValue
        self.allTasks = json["allTasks"].intValue
        self.complated = json["completedTasks"].intValue
    }
}
