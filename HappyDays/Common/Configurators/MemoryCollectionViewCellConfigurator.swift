//
//  MemoryCollectionViewCellConfigurator.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 14/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

class MemoryCollectionViewCellConfigurator: CollectionCellConfigurable {
    func configure(_ cell: UICollectionViewCell, with model: Any) {
        if let c = cell as? MemoryCollectionViewCell, let model = model as? UIImage {
            c.imageView.image = model
        }
    }
}
