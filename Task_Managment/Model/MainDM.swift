//
//  MainDM.swift
//  Task_Managment
//
//  Created by MacBook Pro on 13/01/23.
//

import Foundation
import SwiftyJSON
import Alamofire

struct MainDM {
    var allTasks:Int
    var complatedTask:Int
    var pecent:Int
    var pendingCount:Int
    init(json:JSON) {
        self.allTasks = json["allTasks"].intValue
        self.complatedTask = json["completedTasks"].intValue
        self.pecent = json["percent"].intValue
        self.pendingCount = json["pendingCount"].intValue
    }
}
