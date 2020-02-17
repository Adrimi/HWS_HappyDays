//
//  MemoryCollectionViewController.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 10/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Speech

class MemoryCollectionViewController: BaseCollectionViewController {

    //MARK: - Parametes
    enum PathExtension: String {
        case image = "jpg"
        case thumbnail = "thumb"
        case audio = "m4a"
        case transcript = "txt"
        
        func URL(for memory: URL) -> URL {
            memory.appendingPathExtension(self.rawValue)
        }
    }

    private(set) var memories = [URL]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMemories()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkPermissions()
    }
    
    //MARK: - Buisness logic
    private func loadMemories() {
        /// Remove any existing memories to avoid duplicaions
        memories.removeAll()
        
        /// Pull out a list of all the files stored in our app's documents directory. This needs to be working with URLs, rather than paths strings
        guard let files = try? FileManager.default
            .contentsOfDirectory(at: getDocumentsDirectory(),
                                 includingPropertiesForKeys: nil,
                                 options: []) else {return}
        
        /// Loop over every file that was found, and, if it was a thumbnail, add it to our memoeirs array/
        for file in files where file.lastPathComponent.hasSuffix(".thumb") {
            let noExtension = file.lastPathComponent.replacingOccurrences(of: ".thumb", with: "")
            let memoryPath = getDocumentsDirectory().appendingPathComponent(noExtension)
            memories.append(memoryPath)
        }
        
//        collectionView?.reloadSections(IndexSet(integer: 1))
        setupCollectionView()
    }
    
    private func saveNewMemory(image: UIImage) {
        /// Generate new UUID which will be timestamp
        let memoryName = "memory-\(Date().timeIntervalSince1970)"
        
        /// Create filenames
        let imageName = memoryName + ".jpg"
        let thumbnailName = memoryName + ".thumb"
        
        /// Create absolute URL paths
        do {
            try write(image: image, with: imageName)
            
            /// Create thumbnail image
            if let thumbnail = resize(image: image, to: 200) {
                try write(image: thumbnail, with: thumbnailName)
            }
        } catch {
            print("Failed to save to disk. \(error.localizedDescription)")
        }
        
    }
    
    // MARK: - Helper methods
    private func resize(image: UIImage, to width: CGFloat) -> UIImage? {
        /// Calculate how much we need to bring the width down to match our target size
        let scale = width / image.size.width
        
        /// Bring the height down by the same amount so that the aspect ratio is preserved
        let height = image.size.height * scale
        
        /// Create new image context we can draw into
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        /// Draw the original image into the context
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        /// Pull out the resized version
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        /// End the context so UIKit can clean up
        UIGraphicsEndImageContext()
        
        /// Send it back to the caller
        return newImage
    }
    
    private func write(image: UIImage, with imageName: String) throws {
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try jpegData.write(to: imagePath, options: [.atomicWrite])
        }
    }
    
    private func setupCollectionView() {
        let dataSource = SectionedCollectionViewDataSource.init(
            dataSources: [
                CollectionViewDataSource.init(models: [],
                                              cellConfigurator: SearchCollectionViewCellConfigurator.init()),
                CollectionViewDataSource.init(models: memories,
                                              cellConfigurator: MemoryCollectionViewCellConfigurator.init())
            ]
        )
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        let vc = UIImagePickerController()
        vc.modalPresentationStyle = .formSheet
        vc.delegate = self
        navigationController?.present(vc, animated: true)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func checkPermissions() {
        // chech status for all of the three permissions
        let photosAuthorized = PHPhotoLibrary.authorizationStatus() == .authorized
        let recordingAuthorized = AVAudioSession.sharedInstance().recordPermission == .granted
        let transcribeAuthorized = SFSpeechRecognizer.authorizationStatus() == .authorized
        
        // make a single boolean out of all three
        let authorized = photosAuthorized && recordingAuthorized && transcribeAuthorized
        
        // if we're missiong one, show the first run screen
        if !authorized {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "PermissionsViewController") {
                navigationController?.present(vc, animated: true)
            }
        }
         
    }

}

// MARK: - CollectionView Data Source
//extension MemoryCollectionViewController {
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        2
//    }
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        section == 0 ? 0 : memories.count
//    }
//}
//
//// MARK: - BaseCollectionView Delegate
//extension MemoryCollectionViewController {
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: HDCollectionViewCell = collectionView.dequeue(for: indexPath)
//        let model = memories[indexPath.row]
//        let imageName = PathExtension.thumbnail.URL(for: model).path
//        let image = UIImage(contentsOfFile: imageName)
//
//        cell.setup(with: image)
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: BaseCollectionViewController, cellForItemAt indexPath: IndexPath) -> BaseCollectionViewCell {
//
//    }
//
//}


extension MemoryCollectionViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        if let possibleImage = info[.originalImage] as? UIImage {
            saveNewMemory(image: possibleImage)
            loadMemories()
        }
    }
}

extension MemoryCollectionViewController: UINavigationControllerDelegate {
    
}
