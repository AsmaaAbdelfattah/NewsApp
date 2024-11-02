//
//  Details.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 02/11/2024.
//

import UIKit
import Kingfisher
import Combine
class Details: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var articleImg: UIImageView!{
        didSet{
            articleImg.layer.cornerRadius = 21
        }
    }
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var capsuleView: UIView!{
        didSet{
            capsuleView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var addToFavBtn: UIButton!{
        didSet{
            addToFavBtn.layer.cornerRadius = 28
            addToFavBtn.setTitle("Add to Favourite", for: .normal)
        }
    }
    
    //MARK: Vars
    var article: Article?
    var viewModel = FavouriteViewModel()
    var cancellables = Set<AnyCancellable>()
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindArticle()
        handleSaveToCoreData()
    }
    
    //MARK: bind article details
    func bindArticle(){
        if let article = article{
            articleTitle.text = article.title
            desc.text = article.content
            author.text = article.author
            if let img = article.urlToImage{
                articleImg.kf.indicatorType = .activity
                articleImg.kf.setImage(with: URL(string: img))
            }
        }
    }

    func handleSaveToCoreData(){
    viewModel.$savedSuccesfully.receive(on: DispatchQueue.main).sink {[weak self] succes in
        guard let successed = succes else {return}
        if successed {
            let alert = UIAlertController(title: self?.article?.title , message:"added to favourite succesfully", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
                self?.navigationController?.popViewController(animated: true)
            })
            action.setValue(UIColor.red, forKey: "titleTextColor")
            alert.addAction(action)
            self?.present(alert, animated: true, completion: nil)
        }
        }.store(in: &cancellables)
    }

    @IBAction func favTapped(_ sender: Any) {
        if let article = article, !(article.isFav ?? false){
            viewModel.addArticle(article: article)
        }
    }
}
