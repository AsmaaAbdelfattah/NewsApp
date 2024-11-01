//
//  View.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//


import UIKit
extension UIView{
    func dropShadow(){
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.systemGray4.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 11
        
    }
}
