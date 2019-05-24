//
//  PictureViewController.swift
//  CatorDog
//
//  Created by Booharin on 24/05/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController, HasDependencies {
    
    typealias Dependencies =
        HasPictureService &
        HasCoreMLService
    var di: Dependencies = DI.dependencies
    
    var imageView: UIImageView?
    var resultLabel: UILabel?
    var cameraButton: UIButton?
    var galleryButton: UIButton?
    
    var presenter: PicturePresenterInput?

    override func viewDidLoad() {
        super.viewDidLoad()

        addImageView()
        addResultLabel()
        addCameraButton()
        addGalleryButton()
        
        di.coreMLService.delegate = self
    }
    
    private func addImageView() {
        imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView?.contentMode = .scaleAspectFit
        
        guard let imageView = imageView else { return }
        self.view.addSubview(imageView)
    }
    
    private func addResultLabel() {
    
        presenter?.getLabelFrame() { [unowned self] rect in
            DispatchQueue.main.async {
                self.resultLabel = self.di.pictureService.getResultLabel(rect: rect)
                
                guard let label = self.resultLabel else { return }
                self.view.addSubview(label)
            }
        }
    }
    
    private func addCameraButton() {
        presenter?.getButtonFrame(isCameraButton: true) { [unowned self] rect in
            DispatchQueue.main.async {
                self.cameraButton = self.di.pictureService.getCameraButton(rect: rect)
                
                guard let button = self.cameraButton else { return }
                button.addTarget(self, action: #selector(self.toCamera), for: .touchUpInside)
                self.view.addSubview(button)
            }
        }
    }
    
    private func addGalleryButton() {
        presenter?.getButtonFrame(isCameraButton: false) { [unowned self] rect in
            DispatchQueue.main.async {
                self.galleryButton = self.di.pictureService.getGalleryButton(rect: rect)
                
                guard let button = self.galleryButton else { return }
                button.addTarget(self, action: #selector(self.toGallery), for: .touchUpInside)
                self.view.addSubview(button)
            }
        }
    }
}

extension PictureViewController: PicturePresenterOutput {
    @objc func toCamera() {
        self.presentPhotoPicker(sourceType: .camera)
    }
    
    @objc func toGallery() {
        self.presentPhotoPicker(sourceType: .photoLibrary)
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
}

extension PictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView?.image = image
            di.coreMLService.updateClassifications(for: image)
        }
    }
}

extension PictureViewController: CoreMLServiceDelegate {
    func updateResultLabel(text: String) {
        resultLabel?.text = text
    }
}
