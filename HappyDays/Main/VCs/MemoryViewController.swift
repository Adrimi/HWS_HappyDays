//
//  MemoryViewController.swift
//  HappyDays
//
//  Created by adrian.szymanowski on 10/02/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Speech

class MemoryViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    private(set) var memoryViewModel = MemoryViewModel.init()
    private(set) var dataSource: UICollectionViewDataSource?
//    private(set) var delegate: UICollectionViewDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        memoryViewModel.delegate = self
        memoryViewModel.loadMemories()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkPermissions()
    }
    
   // MARK: - Helper methods
    private func setupCollectionView() {
        
        let images: [UIImage] = memoryViewModel.memories
            .compactMap { memory in
                var mem = memory
                return mem.thumbnail
        }
        
        let dataSource = SectionedCollectionViewDataSource.init(
            dataSources: [
                CollectionViewDataSource.init(models: images,
                                              rID: MemoryCollectionViewCell.rID,
                                              configurator: MemoryCollectionViewCellConfigurator.init())
            ]
        )
        
        self.dataSource = dataSource
        self.collectionView.dataSource = dataSource
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

extension MemoryViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        if let possibleImage = info[.originalImage] as? UIImage {
            let memory = Memory.init(image: possibleImage)
            memoryViewModel.saveMemory(memory: memory)
            memoryViewModel.loadMemories()
        }
    }
}

extension MemoryViewController: UINavigationControllerDelegate {
    
}

extension MemoryViewController: MemoryViewModelDelegate {
    
    func onMemoriesLoad(_ viewModel: MemoryViewModel) {
        setupCollectionView()
        collectionView.reloadData()
    }
    
}

extension MemoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MemoryViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true)
    }
}
