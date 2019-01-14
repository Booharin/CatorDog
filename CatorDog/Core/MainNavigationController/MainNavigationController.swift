//
//  MainNavigationController.swift
//  CatorDog
//
//  Created by Booharin on 12/01/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        self.navigationBar.tintColor = UIColor.white
    }
}
