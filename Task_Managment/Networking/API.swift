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
    static let getProfile: String = baseUrl+EndPoints.getProfileURL
    static let updateProfile: String = baseUrl+EndPoints.updateProfileURL
    static let getHr: String = baseUrl+EndPoints.getHRURL
    static let getImage: String = baseUrl+EndPoints.getImageURL
    
    static func getLogin(number:String, password:String, complation:@escaping (LoginUserDM)->Void) {
       
        let param:[String:Any] = [
            "phoneNumber": number,
            "password": password
        ]
        
        NET.sendRequest(to: loginByPhone, method: .post, headers: nil, param: param) { data in
            guard let data = data else { return }
                let info = data["data"]
                complation(LoginUserDM(json: info))
            
        }
    }
    
    static func getProfile(complation:@escaping (LoginUserDM)->Void) {

        let header: HTTPHeaders = [
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        NET.sendRequest(to: baseUrl + "/task/comment", method: .get, headers:header ,param: nil) { data in
            guard let data = data else {return}
            let myData = LoginUserDM(json: data["data"])
            print("myData",myData)
            complation(myData)
        }
    }

    static func postCommit(taskId:String,text:String,complation:@escaping (ChatDM)->Void) {


        let param:[String : Any] = [
            "taskId":taskId,
            "text":text

        ]
//        SocketHelper.Events.emit(SocketHelper.Events(param))
        NET.sendRequest(to: baseUrl + "/user", method: .get, headers:nil ,param: param) { data in
            guard let data = data else {return}
            let myData = ChatDM(json: data["data"])
            print("data1212121=",data)
            print("myData",myData)
            complation(myData)
        }
    }

    
     
    

    static func getProfile(complation:@escaping (UserDM)->Void) {

        let header: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        NET.sendRequest(to: getProfile, method: .get, headers: header ,param: nil) { data in
            guard let data = data else { return }
            let myData = UserDM(json: data["data"])
            complation(myData)
        }

    }
    

    static func updateProfile(name: String, lastname: String, position: String, password: String, complation: @escaping (UserDM)->Void) {
        let header: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        let params: [String: Any] = [
            "fullName": name+" "+lastname,
            "position": position,
            "password": password
        ]
        
        NET.sendRequest(to: updateProfile, method: .put, headers: header, param: params) { data in
            guard let data = data else { return }
            let myData = UserDM(json: data["data"])
            complation(myData)
        }

    }
    
    static func getTodaysTask(complation:(UserDM)->Void) {
        NET.sendRequest(to: baseUrl + EndPoints.todaysTaskURL, method: .get, headers: nil, param: nil) { data in
            guard let data = data else {return}
            
        }
    }
    
    
    
    
}

//MARK: - URLs
extension API {
    
    enum EndPoints {
        static let loginByPhoneURL = "/login"
        static let getProfileURL = "/user/myself"
        static let updateProfileURL = "/user"
        static let getHRURL = "/user/hr"
        static let getImageURL = "/public/uploads/images/user.png"
        static let todaysTaskURL = "/task/today"
    }
}
