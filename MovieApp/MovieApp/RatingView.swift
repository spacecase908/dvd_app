//
//  ratingView.swift
//  MovieApp
//
//  Created by user194382 on 6/1/21.
//  Feature adapted from -> youtube.com/watch?v=I1dn8BG3JZQ
// Mohamed Al-Ghamdi

import UIKit

class RatingController: UIStackView {
    var starsRating: Int!
    var empty = "star"
    var full = "star.fill"
    
    override func draw(_ rect: CGRect) {
        let myViews = self.subviews.filter{$0 is UIButton}
        var starTag = 1
        for theView in myViews {
            if let theButton = theView as? UIButton{
                theButton.tag = starTag
                if theButton.tag > starsRating {
                    theButton.setImage(UIImage(systemName: empty), for: .normal)
        
                } else {
                    theButton.setImage(UIImage(systemName: full), for: .normal)
                }
                
                theButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                starTag = starTag + 1
                
            }
        }
    }
    
    @objc func pressed(sender: UIButton) {
        starsRating = sender.tag
        let myViews = self.subviews.filter{$0 is UIButton}
        for theView in myViews {
            if let theButton = theView as? UIButton {
                if theButton.tag > sender.tag {
                    theButton.setImage(UIImage(systemName: empty), for: .normal)
                } else {
                    theButton.setImage(UIImage(systemName: full), for: .normal)
                    
                }
            }
        }
        
    }
}
