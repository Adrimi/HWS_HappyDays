//
//  CollectionViewDataSource.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 14/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

class CollectionViewDataSource<Model>: NSObject, UICollectionViewDataSource {
    
    typealias CellConfigurator = CollectionCellConfigurator<Model>
    
    // MARK: - Parameters
    var models: [Model]
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model], cellConfigurator: CellConfigurator) {
        self.models = models
        self.cellConfigurator = cellConfigurator
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.item]
        let cell = collectionView.dequeue(for: indexPath)
        
        cellConfigurator.configure(cell, forDisplaying: model)
        
        return cell
    }
}
