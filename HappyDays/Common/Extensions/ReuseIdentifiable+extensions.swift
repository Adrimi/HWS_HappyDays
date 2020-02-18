//
//  ReuseIdentifiable+extensions.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 18/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

extension ReuseIdentifiable where Self: UIResponder {
    public static var rID: String {
        String.init(describing: self)
    }
}

extension UICollectionReusableView: ReuseIdentifiable {}
