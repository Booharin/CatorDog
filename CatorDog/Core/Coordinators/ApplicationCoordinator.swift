//
//  ApplicationCoordinator.swift
//  CatorDog
//
//  Created by Booharin on 12/01/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

final class ApplicationCoordinator: BaseCoordinator {
    
    override func start() {
        self.toMain()
    }
    
    private func toMain() {
        let coordinator = MainCoordinator()
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
}
