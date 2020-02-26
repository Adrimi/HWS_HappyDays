//
//  FileFormat.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 26/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import Foundation

enum FileFormat: String {
    case image = "jpg"
    case thumbnail = "thumb"
    case audio = "m4a"
    case transcript = "txt"
    
    func addSuffix(to path: URL) -> URL {
        path.appendingPathExtension(rawValue)
    }
}
