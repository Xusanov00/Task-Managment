//
//  LanguageCache.swift
//  TaskManagement
//
//  Created by Ali on 06/01/23.
//

import Foundation

//MARK: - cache
let cache = UserDefaults.standard

//MARK: - enum for KeysDM
enum KeysDM: String {
    case language = "APPLANGUAGE"
}


enum LanguageDM: String {
    case uz = "uz"
    case ru = "ru"
    case en = "en"
}

class SetCache {
    //MARK: - func for saveCache
    class func saveCache(for tf: String?, for keyName: KeysDM) {
        cache.setValue(tf ?? "Optional...", forKey: keyName.rawValue)
    }

    //MARK: - func for getCache
    class func getCache(for keyName: KeysDM) -> String {
        cache.string(forKey: keyName.rawValue) ?? ""
    }

    //MARK: - func for clearCache
    class func clearCache(for keyName: KeysDM) {
        cache.removeObject(forKey: keyName.rawValue)
    }
}
