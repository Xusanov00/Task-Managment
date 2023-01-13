//
//  Cache.swift
//  Task_Managment
//
//  Created by Ali on 13/01/23.
//

import Foundation

class Cache {
    
    static let app_langauge = Keys.APP_LANGUAGE
    
    
    //MARK: SAVE Language to Cache
    static func save(appLanguage lang: AppLanguage) {
        ///saves Language to Cache
        UserDefaults.standard.setValue(lang.rawValue, forKey: app_langauge)
    }
    
    
    //    //MARK: GET Language from Cache
    static func getAppLanguage() -> AppLanguage {
        ///gets Language from Cache
        let lang = UserDefaults.standard.string(forKey: app_langauge)
        switch lang {
        case "uz": return .uz
        case "ru": return .ru
        case "en": return .en
        default:   return .uz
        }
    }
    
    
}


