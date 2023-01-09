//
//  API.swift
//  Task_Managment
//
//  Created by MacBook Pro on 09/01/23.
//

import Foundation
import SwiftyJSON
import Alamofire

class API {
    
    static let url:String = "https://instagram47.p.rapidapi.com/user_following"
    
    static func getData(number:Int,complation:@escaping ([String])->Void) {
        let param:[String:Any] = ["userid":number]
        let headers:HTTPHeaders = [
            "X-RapidAPI-Key": "72f6496a11msha94dc1981014c21p1637d5jsne65d5bf63dbe",
            "X-RapidAPI-Host": "instagram47.p.rapidapi.com"
        ]
        NET.sendRequest(to: url, method: .get, param: param, headers: headers) { data in
//            guard let data = data else {return}
//            let info = data["body"]["users"].array
//            guard let info = info else {return}
//            let myData = info
//            complation(myData)
        }
    }
     
    
}
