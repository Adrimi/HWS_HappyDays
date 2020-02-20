//
//  MemoryCollectionViewCell.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 10/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

class MemoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // border
        imageView.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        imageView.layer.borderWidth = 0.5
        
        // corner
        imageView.layer.cornerRadius = 4
    
        // shadow
        imageView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowRadius = 7.0
        imageView.layer.shadowOpacity = 0.1
        
        imageView.layer.masksToBounds = true
    }
    
}
