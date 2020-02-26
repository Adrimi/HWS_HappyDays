//
//  MemoryViewModel.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 26/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

protocol MemoryViewModelDelegate: class {
    func onMemoriesLoad(_ viewModel: MemoryViewModel)
}

class MemoryViewModel {
    
    // MARK: Parameters
    var memories = [Memory]()
    weak var delegate: MemoryViewModelDelegate?
    
    //MARK: Buisness logic
    func loadMemories() {
        DispatchQueue.global().async {
            /// Remove any existing memories to avoid duplicaions
            self.memories.removeAll()
            
            self.memories = BaseFileManager.shared.loadThumbnails()
                .map { Memory.init(path: $0) }
            
            DispatchQueue.main.async {
                self.delegate?.onMemoriesLoad(self)
            }
        }
    }
    
    func saveMemory(memory: Memory) {
        do {
            try BaseFileManager.shared.save(memory: memory)
        } catch {
            print("Failed to save to disk. \(error.localizedDescription)")
        }
    }
}
