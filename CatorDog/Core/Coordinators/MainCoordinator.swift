//
//  MainCoordinator.swift
//  CatorDog
//
//  Created by Booharin on 12/01/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMainModule()
    }
    
    private func showMainModule() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(MainViewController.self)
        controller.coordinator = self
        
        let rootController = MainNavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
}
