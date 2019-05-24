//
//  PictureService.swift
//  CatorDog
//
//  Created by Booharin on 24/05/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//
import UIKit

protocol HasPictureService {
    var pictureService: IPictureService { get set }
}

protocol IPictureService {
    func getResultLabel(rect: CGRect) -> UILabel
    func getCameraButton(rect: CGRect) -> UIButton
    func getGalleryButton(rect: CGRect) -> UIButton 
}

class PictureService: IPictureService {
    
    private let fontSize: CGFloat = 24
    
    func getResultLabel(rect: CGRect) -> UILabel {
        let label = UILabel(frame: rect)
        
        label.text = "Please, add a photo".localized
        label.font = UIFont.systemFont(ofSize: self.fontSize)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .center
        
        return label
    }
    
    func getCameraButton(rect: CGRect) -> UIButton {
        let button = UIButton(frame: rect)
        if let image = UIImage(named: "icn_camera") {
            button.setImage(image, for: .normal)
        }
        return button
    }
    
    func getGalleryButton(rect: CGRect) -> UIButton {
        let button = UIButton(frame: rect)
        if let image = UIImage(named: "icn_gallery") {
            button.setImage(image, for: .normal)
        }
        return button
    }
}
