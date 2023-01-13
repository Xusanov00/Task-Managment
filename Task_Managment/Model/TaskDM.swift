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
    var taskId: String
    var address: String
    var from: Int
    var to: Int
    var deadline: Int
    var location: TaskLocationDM
    
    init(json:JSON) {
        self.title = json["title"].stringValue
        self.definition = json["description"].stringValue
        self.time = json["startTime"].intValue
        self.priority = json["status"].stringValue
        self.taskId = json["_id"].stringValue
        self.from = json["from"].intValue
        self.to = json["to"].intValue
        self.address = json["address"].stringValue
        self.deadline = json["deadline"].intValue
        self.location = TaskLocationDM(json: json["taskLocation"])
    }
}



struct TaskLocationDM {
    var latitude: Double
    var longitude: Double
    var date: Int
    var _id: String
    
    init(json: JSON) {
        self.latitude = json["latitude"].doubleValue
        self.longitude = json["longitude"].doubleValue
        self.date = json["date"].intValue
        self._id = json["_id"].stringValue
    }
}

