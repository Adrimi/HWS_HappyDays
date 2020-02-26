//
//  UIImage+common.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 26/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

extension UIImage {

    func resize(to width: CGFloat) -> UIImage {
        /// Calculate how much we need to bring the width down to match our target size
        let scale = width / size.width
        
        /// Bring the height down by the same amount so that the aspect ratio is preserved
        let height = size.height * scale
        
        /// Create new image context we can draw into
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        /// Draw the original image into the context
        draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        /// Pull out the resized version
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        /// End the context so UIKit can clean up
        UIGraphicsEndImageContext()
                            
        /// Send it back to the caller
        return newImage ?? self
    }
    
}

