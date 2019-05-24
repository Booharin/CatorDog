//
//  Dependencies.swift
//  CatorDog
//
//  Created by Booharin on 24/05/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

protocol HasDependencies: class {
    associatedtype Dependencies
    
    var di: Dependencies { get set }
}

struct Dependencies:
    HasPictureService,
HasCoreMLService {
    
    var pictureService: IPictureService
    var coreMLService: ICoreMLService
}

enum DI {
    static var dependencies: Dependencies!
}

class AppDIContainer {
    
    func createAppDependencies() -> Dependencies {
        
        let d = Dependencies(pictureService: PictureService(),
                             coreMLService: CoreMLService())
        
        return d
    }
}
