//
//  StoryboardHelper.swift
//  CatorDog
//
//  Created by Booharin on 12/01/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension UIViewController: StoryboardIdentifiable { }

extension StoryboardIdentifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
        guard let viewController =
            self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
                
                fatalError("ViewController with identifier \(T.storyboardIdentifier) not found")
        }
        
        return viewController
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController =
            self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
                
                fatalError("ViewController with identifier \(T.storyboardIdentifier) not found")
        }
        
        return viewController
    }
}
