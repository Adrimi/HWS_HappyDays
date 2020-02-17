//
//  CollectionCellConfigurator.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 14/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

class CollectionCellConfigurator<Model>: CollectionCellConfigurable {
    let models: [Model]
    
    init(_ models: [Model]) {
        self.models = models
    }
    
    func configure(_ cell: UICollectionViewCell, forDisplaying model: Model) {
        fatalError("CollectionCellConfigurator configure not implemented")
    }
}
