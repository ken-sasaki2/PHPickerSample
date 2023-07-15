//
//  ViewController.swift
//  PHPickerSample
//
//  Created by sasaki.ken on 2023/07/15.
//

import UIKit
import PhotosUI

final class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    private var selection = [String: PHPickerResult]()
    private var selectedAssetIdentifiers = [String]()
    private var selectedAssetIdentifierIterator: IndexingIterator<[String]>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func presentPicker() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .any(of: [.images, .livePhotos, .videos])
        configuration.preferredAssetRepresentationMode = .current
        configuration.selection = .ordered
        configuration.selectionLimit = 0
        configuration.preselectedAssetIdentifiers = selectedAssetIdentifiers
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    @IBAction func onOpenButtonTapped(_ sender: UIButton) {
        presentPicker()
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let existingSelection = self.selection
        var newSelection = [String: PHPickerResult]()

        results.forEach { result in
            guard let identifier = result.assetIdentifier else {
                return
            }
            newSelection[identifier] = existingSelection[identifier]
        }
        
        // Track the selection in case the user deselects it later.
        selection = newSelection
        selectedAssetIdentifiers = results.map(\.assetIdentifier!)
        selectedAssetIdentifierIterator = selectedAssetIdentifiers.makeIterator()
        
        print("didFinishPicking:", selectedAssetIdentifiers)
        print("didFinishPicking:", selectedAssetIdentifierIterator)
        
        dismiss(animated: true)
    }
}
 
