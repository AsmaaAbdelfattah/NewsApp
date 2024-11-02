//
//  Details.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 02/11/2024.
//

import UIKit
import Kingfisher
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
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       bindArticle()
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


    @IBAction func favTapped(_ sender: Any) {
   
    }
}
