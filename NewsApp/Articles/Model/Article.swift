//
//  Articles.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//

import Foundation
struct Articles: Decodable {
    var status: String
    var code: String?
    var message:String?
    var totalResults: Int?
    var articles: [Article]?
}
struct Source: Decodable{
    var id: String?
    var name: String
}
struct Article: Decodable {
    var source: Source
    var author: String?
    var title:String
    var description:String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String
    var isFav:Bool?

}
