//
//  PicturePresenter.swift
//  CatorDog
//
//  Created by Booharin on 24/05/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit

class PicturePresenter {
    
    weak var view: PicturePresenterOutput?
    var router: PictureRouter?
    private let offSet: CGFloat = 20
    private let elementHeight: CGFloat = 50
    private let buttonWidth: CGFloat = 50
    private let screenRect = UIScreen.main.bounds
}

extension PicturePresenter: PicturePresenterInput {
    
    func getLabelFrame(completion: @escaping (CGRect) -> ()) {
        DispatchQueue.global().async {
            let rect = CGRect(x: self.offSet,
                              y: (self.screenRect.height / 4) * 3,
                              width: self.screenRect.width - self.offSet * 2,
                              height: self.elementHeight)
            
            completion(rect)
        }
    }
    
    func getButtonFrame(isCameraButton: Bool, completion: @escaping (CGRect) -> ()) {
        DispatchQueue.global().async {
            var buttonOffset = self.offSet
            
            if isCameraButton == false {
                buttonOffset = self.screenRect.width - (self.offSet + self.buttonWidth)
            }
            
            let rect = CGRect(x: buttonOffset,
                              y: self.screenRect.height - (self.elementHeight + self.offSet),
                              width: self.buttonWidth,
                              height: self.elementHeight)
            
            completion(rect)
        }
    }
}
