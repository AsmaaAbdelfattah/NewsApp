//
//  UserDefaults.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//

import Foundation
enum UserDefaultsKeys: String{
    case baseUrl
    case apiKey
}
extension UserDefaults{
    func setBase(value: String){
        setValue(value, forKey: UserDefaultsKeys.baseUrl.rawValue)
    }
    func getBase() -> String{
        return string(forKey: UserDefaultsKeys.baseUrl.rawValue) ?? ""
    }
    func setApiKey(value: String){
        setValue(value, forKey: UserDefaultsKeys.apiKey.rawValue)
    }
    func getApiKey() -> String{
        return string(forKey: UserDefaultsKeys.apiKey.rawValue) ?? ""
    }
}
