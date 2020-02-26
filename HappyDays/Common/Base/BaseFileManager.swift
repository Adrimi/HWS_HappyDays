//
//  BaseFileManager.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 26/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

struct BaseFileManager {
    
    // MARK: Parameters
    static let shared = BaseFileManager.init()
    
    var defaultDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // MARK: - Load Methods
    func loadThumbnails() -> [URL] {
        guard let files = try? pathsToFilesAt(directory: defaultDirectory) else { return [] }
        print("there is", files.count, "files")
        return files.filterMap(with: FileFormat.thumbnail.rawValue)
    }
    
    // MARK: - Save methods
    func save(memory: Memory) throws {
        var mem = memory
        try save(image: mem.image, filename: mem.filename)
        try save(thumbnail: mem.image, filename: mem.filename)
    }
    
    func save(image: UIImage?, filename: String) throws {
        try write(image: image, filename: filename)
    }

    func save(thumbnail: UIImage?, filename: String) throws {
        let image = thumbnail?.resize(to: 200)
        try write(image: image, filename: filename)
    }
    
    // MARK: - Helper methods
    private func pathsToFilesAt(directory: URL) throws -> [URL] {
        
        /// Pull out a list of all the files stored in our app's documents directory.
        /// This needs to be working with URLs, rather than paths strings
        try FileManager.default.contentsOfDirectory(at: defaultDirectory,
                                                     includingPropertiesForKeys: nil,
                                                     options: [])
    }
    
    private func write(image: UIImage?, filename: String) throws {
        let imagePath = defaultDirectory.appendingPathComponent(filename)
        if let jpegData = image?.jpegData(compressionQuality: 0.8) {
            try jpegData.write(to: imagePath, options: [.atomicWrite])
        }
    }
}

extension Collection where Element == URL {
    func filterMap(with suffix: String) -> [URL] {
        filter { $0.lastPathComponent.hasSuffix(suffix) }
            .map { $0.lastPathComponent.replacingOccurrences(of: suffix, with: "") }
            .map { BaseFileManager.shared.defaultDirectory.appendingPathComponent($0) }
    }
}
