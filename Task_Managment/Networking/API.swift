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
    
    
    //BaseURL
    static let baseUrl:String = "https://taskbotapi.roundedteam.uz"
    
    
    //URLs
    
    static let loginByPhone: String = baseUrl+EndPoints.loginByPhoneURL
    static let getProfile: String = baseUrl+EndPoints.getUpdtprofileURL
    static let getHr: String = baseUrl+EndPoints.getHRURL
    static let getImage: String = baseUrl+EndPoints.getImageURL
    
    static func getLogin(number:String, password:String, complation:@escaping (LoginUserDM)->Void) {
       
        let param:[String:Any] = [
            "phoneNumber": number,
            "password": password
        ]
        
        NET.sendRequest(to: loginByPhone, method: .post, headers: nil, param: param) { data in
            guard let data = data else {return }
                let info = data["data"]
                complation(LoginUserDM(json: info))
            
        }
    }
    

    static func getProfile(complation:@escaping (LoginUserDM)->Void) {

        let header: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        NET.sendRequest(to: getProfile, method: .get, headers:header ,param: nil) { data in
            guard let data = data else {return}
            let myData = LoginUserDM(json: data["data"])
            complation(myData)
        }

    }
    
    
    static func updateProfile(complation: @escaping ()->Void) {
        
    }
    
}

//MARK: - URLs
extension API {
    
    enum EndPoints {
        static let loginByPhoneURL = "/login"
        static let getUpdtprofileURL = "/user"
        static let getHRURL = "/user/hr"
        static let getImageURL = "/public/uploads/images/user.png"
        
    }
}
