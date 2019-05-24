//
//  PicturePresenterInput.swift
//  CatorDog
//
//  Created by Booharin on 24/05/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//
import UIKit

protocol PicturePresenterInput {
    func getLabelFrame(completion: @escaping (CGRect) -> ())
    func getButtonFrame(isCameraButton: Bool, completion: @escaping (CGRect) -> ())
}
