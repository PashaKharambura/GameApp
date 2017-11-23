//
//  Extentions ond other.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/9/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import Foundation
import UIKit

func sqr(_ value: Int) -> Double {
    return Double(value*value)
}


extension Character {
    
    var code: Int {
        return Int(self.unicodeScalars.first?.value ?? 0)
    }
    
}

