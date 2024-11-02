//
//  FavouriteViewModel.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 02/11/2024.
//

import Foundation
import CoreData
class FavouriteViewModel:ObservableObject{
   
    let container: NSPersistentContainer
    @Published var savedEntity:[FavouriteArticleEntity] = []
    @Published var savedSuccesfully:Bool?
    init(){
        container = NSPersistentContainer(name: "FavouriteArticles")
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("core data error \(error.localizedDescription)")
            }else{
                print("success core data")
            }
        }
        fetchArticles()
    }
    
    func fetchArticles(){
        let request = NSFetchRequest<FavouriteArticleEntity>(entityName: "FavouriteArticleEntity")
        do {
          savedEntity =  try container.viewContext.fetch(request)
           
        }catch let error {
            print("fetch core data error \(error.localizedDescription)")
        }
    }
    
    func addArticle(article:Article){
        let newArticle = FavouriteArticleEntity(context: container.viewContext)
        newArticle.id = UUID()
        newArticle.sourceId = article.source.id
        newArticle.author = article.author
        newArticle.content = article.content
        newArticle.desc = article.description
        newArticle.isFav = article.isFav ?? false
        newArticle.publishedAt = article.publishedAt
        newArticle.title = article.title
        newArticle.url = article.url
        newArticle.urlToImage = article.urlToImage
      
        saveArticle()
    }
    
    func saveArticle(){
        do{
          try  container.viewContext.save()
            savedSuccesfully = true
            fetchArticles()
        }catch let error{
            print("save core data error \(error.localizedDescription)")
        }
    }
}
