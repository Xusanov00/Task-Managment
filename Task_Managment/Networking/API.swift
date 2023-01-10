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
    
    static let url:String = "https://taskbotapi.roundedteam.uz"
    
    
    
    
    static func getData(number:String,password:String,complation:@escaping (DataDM)->Void) {
        let param:[String:Any] = [
            "phoneNumber": number,
            "password": password
        ]
        
        NET.sendRequest(to: url + "/login", method: .post, headers: nil, param: param) { data in
            guard let data = data else {return }
                let info = data["data"]
                print("jsondata=",DataDM(json: info))
                complation(DataDM(json: info))
            
        }
    }
    
    static func getProfile(complation:@escaping (DataDM)->Void) {

        let header: HTTPHeaders = [
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        NET.sendRequest(to: url + "/user", method: .get, headers:header ,param: nil) { data in
            guard let data = data else {return}
            let myData = DataDM(json: data["data"])
            print("myData",myData)
            complation(myData)
        }
    }
    
    
    
    
     
    
}
