//
//  ViewController.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//

import UIKit
import Combine
import NVActivityIndicatorView
class ArticlesVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var date: UIDatePicker!{
        didSet{
            date.setValue(UIColor.systemBlue, forKey: "textColor")
        }
    }
    @IBOutlet weak var articlesCv: UICollectionView!{
        didSet{
            articlesCv.register(UINib(nibName: "ArticlesCVCell", bundle: nil), forCellWithReuseIdentifier: "ArticlesCVCell")
            articlesCv.dataSource = self
            articlesCv.delegate = self
        }
    }
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //MARK: Vars
    var cancellables = Set<AnyCancellable>()
    var viewModel = ArticleViewModel()
    var searchTxt:String = "tesla"
    var dateValue:String?
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dateValue = formatDate(from: date.date)
        if let date = dateValue {
            bindArticles(date: date, searchTxt: searchTxt)
        }
    }
 
   //MARK: get data
    func bindArticles(date:String, searchTxt:String){
        indicator.showIndicator(start: true)
        viewModel.getArticles(date: date, searchTxt: searchTxt)
        viewModel.$articles.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.indicator.showIndicator(start: false)
            self?.articlesCv.reloadData()
        }.store(in: &cancellables)
    }
    

    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        dateValue = formatDate(from: sender.date)
        if let date = dateValue {
            bindArticles(date: date, searchTxt: searchTxt)
        }
        dismiss(animated: true)
    }
    
}

extension ArticlesVC:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticlesCVCell", for: indexPath) as? ArticlesCVCell else {     return UICollectionViewCell()}
            cell.injectArticle(article: viewModel.articles[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (articlesCv.frame.width / 2)  , height: 240)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
extension ArticlesVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            bindArticles(date: dateValue ?? "", searchTxt: "tesla")
        }else{
            bindArticles(date: dateValue ?? "", searchTxt: searchText)
        }
    }
    
}
