//
//  MemoryCollectionViewCellConfigurator.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 14/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

class MemoryCollectionViewCellConfigurator: CollectionCellConfigurator<Memory> {
    override func configure(_ cell: UICollectionViewCell, forDisplaying model: Memory) {
        if let c = cell as? MemoryCollectionViewCell {
            c.imageView.image = model.image
        }
    }
}
