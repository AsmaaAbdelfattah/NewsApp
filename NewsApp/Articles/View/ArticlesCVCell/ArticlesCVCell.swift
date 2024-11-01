//
//  ArticlesCVCell.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//

import UIKit
import Kingfisher
class ArticlesCVCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!{
        didSet{
            cardView.dropShadow()
        }
    }
    
    @IBOutlet weak var articleImg: UIImageView!{
        didSet{
            articleImg.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var articleTit: UILabel!
    @IBOutlet weak var capsuleView: UIView!{
        didSet{
            capsuleView.layer.cornerRadius = 13
        }
    }
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func injectArticle(article: Article){
        articleTit.text = article.title
        descLbl.text = article.content
        authorLbl.text = article.author
        if let img = article.urlToImage{
            articleImg.kf.indicatorType = .activity
            articleImg.kf.setImage(with: URL(string: img))
        }
        
    }
}
