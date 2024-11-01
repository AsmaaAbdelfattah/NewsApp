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
    func getArticles() {
        networkService.articlePublisher.sink { completion in
            switch completion {
            case .finished:
                print("finished")
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        } receiveValue: {[weak self] articles in
            print(articles)
            self?.articles = articles.articles?.reversed() ?? []
        }.store(in: &cancellables)

    }
}
