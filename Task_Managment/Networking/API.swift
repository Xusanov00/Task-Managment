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
    static let getTodaysTask: String = baseUrl + EndPoints.todaysTaskURL
    static let getTaskID: String = baseUrl+EndPoints.getTaskIDURL
    static let commentToTask: String = baseUrl+EndPoints.commentToTaskURL
    
    
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
    
    static func getComments(taskID: String, complation: @escaping ([String])->Void) {
        Loader.start()
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        NET.sendRequest(to: commentToTask+"/\(taskID)", method: .get, headers: header, param: nil) { data in
            guard let data = data else { return }
            let commentsData = data["data"].arrayValue.map{ CommentDM(json: $0).text}
            complation(commentsData)
        }
        
    }
    
    
    static func getTodaysTask(day: Int, complation:@escaping([TaskDM])->Void) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        
        let params: [String: Any] = [
            "day": day
        ]
        
        NET.sendURLRequest(to: getTodaysTask, method: .get, headers: headers, param: params) { data in
            guard let data = data else {return}
            print("dataToday = ",data)
            if let info = data["data"]["data"].array {
             
                let mydata = info.map{TaskDM(json: $0)}
                complation(mydata)
            }
            


        }
    }
    
    static func getCommentTask(taskID: String, textComment: String, complation: @escaping (CommentDM)->Void) {
        
        let header : HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        let param:[String:Any] = [
            "taskId" : taskID,
            "text" : textComment
        ]
        
        NET.sendRequest(to: commentToTask, method: .post, headers: header, param: param) { data in
            guard let data = data else { return }
            let commentData = data["data"]
            complation(CommentDM(json: commentData))
            


        }
    }
    
    
    static func getTaskID(taskID: String, complation:@escaping (TaskDM)->Void){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        NET.sendRequest(to: getTaskID+taskID, method: .get, headers: headers, param: nil) { data in
            guard let data = data else {return}
            let info = TaskDM(json: data["data"])
            print("data=",data)
            complation(info)
        }
        
    }
    
    
    static func getMainPage(complation:@escaping (MainDM)->Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        NET.sendRequest(to: baseUrl + EndPoints.getHome, method: .get, headers: headers, param: nil) { data in
            guard let data = data else {return}
            let info = MainDM(json: data["data"])
            complation(info)
            
        }
    }
    
    
    
    
    static func getWeekendlyStatus(day:Int,complation: @escaping ([WeekDM])->Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "TOKEN")!
        ]
        let params:[String:Any] = [
            "day": day
        ]
        NET.sendURLRequest(to: baseUrl + EndPoints.weekStatus, method: .get, headers: headers, param: params) { data in
            guard let data = data else {return}
            
            let mydata = data["data"].array
            guard let mydata = mydata else {return}
            let info = mydata.map{WeekDM(json: $0) }
           
             complation(info)
            
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
        static let todaysTaskURL = "/task/day"
        static let taskID = "/task/63b82310464c9232856ccd1c"
        static let commentToTaskURL = "/task/comment"
        static let getHome = "/task/main"
        static let getTaskIDURL = "/task/"
    }
}

