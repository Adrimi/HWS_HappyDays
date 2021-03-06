//
//  CollectionCellConfigurable.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 14/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

protocol CollectionCellConfigurable {
    func configure(_ cell: UICollectionViewCell, with model: Any)
}
