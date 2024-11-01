//
//  Indicator.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//

import Foundation
import Foundation
import NVActivityIndicatorView

extension NVActivityIndicatorView{
    public func showIndicator(start:Bool){
        self.isHidden = !start
        if start{
            self.type = .ballBeat
            self.color = .blue
            self.startAnimating()
        }else{
            self.stopAnimating()
        }
    }
}
