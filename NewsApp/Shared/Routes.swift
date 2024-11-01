//
//  Routes.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//

import Foundation

enum Networking{
    private var baseURL: String { return  UserDefaults.standard.getBase()}
   
    case articles(String , String)
}
extension Networking{

    var fullPath :String {
        var endPoint: String
        switch self {
        case .articles(let date , let searchTxt):
            endPoint = "/everything?q=\(searchTxt)&from=\(date)&sortBy=popularity&apiKey=\(UserDefaults.standard.getApiKey())"
        }
        return baseURL + endPoint
    }
}
