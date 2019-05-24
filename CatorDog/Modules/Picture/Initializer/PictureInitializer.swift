//
//  PictureInitializer.swift
//  CatorDog
//
//  Created by Booharin on 24/05/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

class PictureInitializer {
    
    func initModule(navigationController: MainNavigationController?) -> PictureViewController {
        let router = PictureRouter()
        router.navigationController = navigationController
        
        let viewController = PictureViewController()
        
        let presenter = PicturePresenter()
        presenter.view = viewController
        presenter.router = router
        
        return viewController
    }
    
}
