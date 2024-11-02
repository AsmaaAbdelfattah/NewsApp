//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//
import Combine
import Foundation
class ArticleViewModel {
    let networkService = NetworkServiceManager.getInstance()

    @Published var articles: [Article] = []
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    func getArticles(date:String, searchTxt:String) {
        networkService.getArticles(date: date, searchTxt: searchTxt).sink { completion in
            switch completion {
            case .finished:
                print("finished")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: {[weak self] articles in
           
            self?.articles =  articles.articles?.reversed() ?? []
            print( self?.articles.count)
        }.store(in: &cancellables)

    }
}
