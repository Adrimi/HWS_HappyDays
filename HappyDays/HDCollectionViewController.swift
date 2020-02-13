//
//  HDCollectionViewController.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 10/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Speech

class HDCollectionViewController: UICollectionViewController {

    //MARK: - Parametes
    private(set) var memories = [URL]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMemories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkPermissions()
    }
    
    //MARK: - Major mehtods
    private func loadMemories() {
        /// Remove any existing memories. Avoid duplication( set?)
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
        
        collectionView?.reloadSections(IndexSet(integer: 1))
    }
    
    // MARK: - Helper methods
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

