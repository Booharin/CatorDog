//
//  String+Localizable.swift
//  CatorDog
//
//  Created by Booharin on 13/01/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import Foundation

extension String {
    
    var localized : String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
    
}
