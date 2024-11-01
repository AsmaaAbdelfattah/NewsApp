//
//  Routes.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//

import Foundation

enum Networking{
    private var baseURL: String { return  UserDefaults.standard.getBase()}
   
    case articles
}
extension Networking{

    var fullPath :String {
        var endPoint: String
        switch self {
        case .articles:
            endPoint = ""
        }
        return baseURL + endPoint
    }
}
