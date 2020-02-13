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

    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkPermissions()
    }
    
    // MARK: - Helper methods
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

