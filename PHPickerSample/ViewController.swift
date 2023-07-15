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
    private var picker: PHPickerViewController?
    private var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
    private var selection = [String: PHPickerResult]()
    private var selectedAssetIdentifiers = [String]()
    private var selectedAssetIdentifierIterator: IndexingIterator<[String]>?
    private var identifier = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        configuration.filter = nil
        configuration.preferredAssetRepresentationMode = .current
        configuration.selection = .ordered
        configuration.selectionLimit = 0
        configuration.preselectedAssetIdentifiers = selectedAssetIdentifiers
        
        picker = PHPickerViewController(configuration: configuration)
        picker?.delegate = self
    }
    
    @IBAction func onOpenButtonTapped(_ sender: UIButton) {
        guard let picker = picker else {
            return
        }
        present(picker, animated: true)
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
        
        
        print("kenken", selectedAssetIdentifiers)
        print("kenken", selectedAssetIdentifierIterator)
        
        dismiss(animated: true)
    }
}
 
