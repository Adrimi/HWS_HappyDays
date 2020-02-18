//
//  CollectionViewDataSource.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 14/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

class CollectionViewDataSource<Model>: NSObject, UICollectionViewDataSource {
    typealias Configurator = CollectionCellConfigurable
    
    // MARK: - Parameters
    // NOTE: - Only this Datasource should store models array
    private let models: [Model]
    private let rID: String
    private let configurator: Configurator
    
    init(models: [Model], rID: String, configurator: Configurator) {
        self.models = models
        self.rID = rID
        self.configurator = configurator
    }
    
    @objc func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.item]
        print("section: \(indexPath.section), item: \(indexPath.item)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rID, for: indexPath)
        
        configurator.configure(cell, with: model)
        
        print(cell.frame)
        return cell
    }
    /**
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: rID, for: indexPath)
        return view
    }
 */
}
