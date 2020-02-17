//
//  BaseCollectionViewCell.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 14/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    static var rID: String {
        String.init(describing: self)
    }
}

