//
//  UIView+reuseIdentifiable.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 14/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeue<Cell: UICollectionViewCell> (for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.rID, for: indexPath) as? Cell else {
            fatalError("Unable to dequeue Reusable Collection Cell")
        }
        return cell
    }
}
