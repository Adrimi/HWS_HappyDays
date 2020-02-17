//
//  PermissionsViewController.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 11/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

import AVFoundation // microphone
import Photos // gallery
import Speech // Speech recognition

class PermissionsViewController: UIViewController {

    // MARK: - Parameters
    @IBOutlet weak var descLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func requestPermissions(_ sender: Any) {
        requestPhotoPermissions()
    }
    
    private func requestPhotoPermissions() {
        PHPhotoLibrary.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.requestRecordPermissions()
                } else {
                    self.descLabel.text = "Photos permission was declined; please enable it in settings then tap Continue again."
                }
            }
        }
    }
    
    private func requestRecordPermissions() {
        AVAudioSession.sharedInstance().requestRecordPermission() { [unowned self] allowed in
            DispatchQueue.main.async {
                if allowed {
                    self.requestTranscribePermissions()
                } else {
                    self.descLabel.text = "Recording permission was declined; please enable it in settings then tap Continue again."
                }
            }
        }
    }
    
    private func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.authorizationComplete()
                } else {
                    self.descLabel.text = "Transcription permission was declined; please enable it in settings then tap Continue again."
                }
            }
        }
    }
    
    private func authorizationComplete() {
        dismiss(animated: true)
    }

}
