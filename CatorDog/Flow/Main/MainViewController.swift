//
//  MainViewController.swift
//  CatorDog
//
//  Created by Booharin on 12/01/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit
import CoreML
import Vision
import ImageIO

class MainViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.text = "Please, add a photo".localized
    }
    
    //MARK: - MLModel setup
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: PetsClassifier().model)
            
            let request = VNCoreMLRequest(model: model,
                                          completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    //MARK: - perform requests
    func updateClassifications(for image: UIImage) {
        resultLabel.text = "Classifying...".localized
        
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    // Updates the UI with the results of the classification.
    //MARK: - process classifications
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.resultLabel.text = "Unable to classify image.\n\(error!.localizedDescription)"
                return
            }
            guard let classifications = results as? [VNClassificationObservation] else { return }
            
            if classifications.isEmpty {
                self.resultLabel.text = "Nothing recognized."
            } else {
                let topClassifications = classifications.prefix(2)
                let correctClassifications = topClassifications.sorted(by: { $0.confidence > $1.confidence })
                
                let identifier = correctClassifications.first?.identifier == "Cat" ? "Cat".localized : "Dog".localized
                self.resultLabel.text = "It's a".localized + " " + identifier + "!"
            }
        }
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        self.presentPhotoPicker(sourceType: .camera)
    }
    
    @IBAction func takeFromGallery(_ sender: UIButton) {
        self.presentPhotoPicker(sourceType: .photoLibrary)
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        updateClassifications(for: image)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
