//
//  UIView+reuseIdentifiable.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 14/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeue<Cell: BaseCollectionViewCell> (for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.rID, for: indexPath) as? Cell else { return Cell() }
        return cell
    }
}
