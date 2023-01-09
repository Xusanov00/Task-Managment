//
//  NET.swift
//  Task_Managment
//
//  Created by MacBook Pro on 09/01/23.
//

import Foundation
import SwiftyJSON
import Alamofire
class NET {
    static let headers:HTTPHeaders  = []
    
    
    static func sendRequest(to url:String,method:HTTPMethod,param:Parameters?,complation: @escaping (JSON?)->Void){
        
        AF.request(url,method: method,parameters: param,encoding: JSONEncoding.default,headers: headers).responseData { response in
            switch response.result {
            case.success(let data):
                let jsonData = JSON(data)
                complation(jsonData)
            case.failure(let error):
                print("error=",error)
                
            }
        }
    }
}
