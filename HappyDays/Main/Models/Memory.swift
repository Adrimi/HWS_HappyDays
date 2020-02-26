//
//  Memory.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 26/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

struct Memory {
    
    let path: URL
    let filename = "memory-\(Date.init().timeIntervalSince1970)"
    
    lazy var thumbnail = UIImage.init(contentsOfFile: path(to: .thumbnail))
    lazy var image = UIImage.init(contentsOfFile: path(to: .image))

    init(image: UIImage? = nil) {
        self.path = BaseFileManager.shared.defaultDirectory.appendingPathComponent(filename)
        self.image = image
    }
    
    init(path: URL) {
        self.path = path
    }
    
    private func path(to file: FileFormat) -> String {
        file.addSuffix(to: path).path
    }
    
}

