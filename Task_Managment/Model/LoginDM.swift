//
//  LoginDM.swift
//  Task_Managment
//
//  Created by MacBook Pro on 09/01/23.
//

import Foundation
import UIKit
import SwiftyJSON
struct LoginDM {
    var isDirector:Bool
    var firstName:String
    var fullName:String
    var position:String
    var phoneNumber:String
    var password:String
    var isAdmen:String
    var token:String
}
struct DataDM {
    var phoneNumber:String
    var password:String
    var token:String
    
    init(json:JSON) {
        self.phoneNumber = json["phoneNumber"].stringValue
        self.password = json["password"].stringValue
        self.token = json["token"].stringValue
    }
}
