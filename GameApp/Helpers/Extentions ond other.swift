//
//  Extentions ond other.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/9/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import Foundation

extension Character {
    
    var code: Int {
        return Int(self.unicodeScalars.first?.value ?? 0)
    }
    
}
