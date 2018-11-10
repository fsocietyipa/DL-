//
//  SubjectCell.swift
//  DL++
//
//  Created by Nurtugan on 11/8/18.
//  Copyright © 2018 hackday. All rights reserved.
//

import UIKit
import Cards

class SubjectCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: CardHighlight!
    
    func displayContent(title: String, itemTitle: String){
        cardView.title = title
        cardView.itemTitle = itemTitle
    }
    
    override func prepareForReuse() {
        cardView.backgroundImage = nil
    }

}
