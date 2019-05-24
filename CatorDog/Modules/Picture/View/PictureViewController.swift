//
//  PictureViewController.swift
//  CatorDog
//
//  Created by Booharin on 24/05/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    
    var presenter: PicturePresenterInput?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension PictureViewController: PicturePresenterOutput {
    
}
