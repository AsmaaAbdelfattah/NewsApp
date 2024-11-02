//
//  ViewController.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//

import UIKit
extension UIViewController{
    
    //MARK: format date
    func formatDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    func removeRightButton(){
        guard let subviews = self.navigationController?.navigationBar.subviews else{return}
        for view in subviews{
            if view.tag != 0{
                view.removeFromSuperview()
            }
        }
    }
    
    func addRightButton(){
        let rightButton = UIButton()
        rightButton.setTitle("", for: .normal)
        rightButton.setImage(UIImage(named: "heart"), for: .normal)
        rightButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        navigationController?.navigationBar.addSubview(rightButton)
        rightButton.tag = 1
        rightButton.frame = CGRect(x: self.view.frame.width, y: 0, width: 120, height: 20)
        let targetView = self.navigationController?.navigationBar
        let trailingContraint = NSLayoutConstraint(item: rightButton, attribute:
            .trailingMargin, relatedBy: .equal, toItem: targetView,
                             attribute: .trailingMargin, multiplier: 1.0, constant: -16)
        let bottomConstraint = NSLayoutConstraint(item: rightButton, attribute: .bottom, relatedBy: .equal,
                                        toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -6)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
    }
    
    //MARK: handle nav to fav screen
    @objc func favButtonTapped(){
        let vc = Favourite(nibName: "Favourite", bundle: nil)
        vc.title = "Favourite"
        navigationController?.pushViewController(vc, animated: true)
    }
}
