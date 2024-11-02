//
//  Favourite.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 02/11/2024.
//

import UIKit
import Combine
class Favourite: UIViewController {

    @IBOutlet weak var favCV: UICollectionView!{
        didSet{
           favCV.register(UINib(nibName: "ArticlesCVCell", bundle: nil), forCellWithReuseIdentifier: "ArticlesCVCell")
           favCV.dataSource = self
            favCV.delegate = self
        }
    }
    
    //MARK: vars
    var viewModel = FavouriteViewModel()
    var cancellables = Set<AnyCancellable>()
    
    //MARK: handle lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
      readData()
        
    }
    
    //MARK: handle read data from core data and bind it to cv
    func readData(){
        viewModel.fetchArticles()
        viewModel.$savedEntity.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.favCV.reloadData()
        }.store(in: &cancellables)
    }
    func convertFromContextIntoArticle(article: FavouriteArticleEntity) -> Article{
        let article = Article(source: Source(id: article.sourceId, name: ""), author:article.author ?? "", title: article.title ?? "", description: article.description, url:  "", urlToImage: article.urlToImage  ?? "", publishedAt:  "", content: article.content ?? "" ,isFav: article.isFav )
        return article
    }
    
    
}
extension Favourite: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.savedEntity.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticlesCVCell", for: indexPath) as? ArticlesCVCell else {     return UICollectionViewCell()}
        cell.injectArticle(article:convertFromContextIntoArticle(article: viewModel.savedEntity[indexPath.row]))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (favCV.frame.width / 2)  , height: 240)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = Details(nibName: "Details", bundle: nil)
//        vc.title = "Details"
//        vc.article = viewModel.savedEntity[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
//    }
}
