//
//  MainCoordinator.swift
//  CatorDog
//
//  Created by Booharin on 12/01/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
    weak var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMainModule()
    }
    
    private func showMainModule() {
        let rootController = MainNavigationController()
        
        let viewController = PictureInitializer().initModule(navigationController: rootController)
        
        rootController.setViewControllers([viewController], animated: false)
        setAsRoot(rootController)
        self.rootController = rootController
    }
}
