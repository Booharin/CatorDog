//
//  CoreMLService.swift
//  CatorDog
//
//  Created by Booharin on 24/05/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//
import UIKit
import CoreML
import Vision
import ImageIO

protocol CoreMLServiceDelegate: class {
    func updateResultLabel(text: String)
}

protocol ICoreMLService {
    func updateClassifications(for image: UIImage)
    func processClassifications(for request: VNRequest, error: Error?)
}

class CoreMLService: ICoreMLService {
    
    weak var delegate: CoreMLServiceDelegate?
    
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
                self.delegate?.updateResultLabel(text: "Unable to classify image.\n\(error!.localizedDescription)")
                return
            }
            guard let classifications = results as? [VNClassificationObservation] else { return }
            
            if classifications.isEmpty {
                self.delegate?.updateResultLabel(text: "Nothing recognized.")
            } else {
                let topClassifications = classifications.prefix(2)
                let correctClassifications = topClassifications.sorted(by: { $0.confidence > $1.confidence })
                
                let identifier = correctClassifications.first?.identifier == "Cat" ? "Cat".localized : "Dog".localized
                self.delegate?.updateResultLabel(text: "It's a".localized + " " + identifier + "!")
            }
        }
    }
}
