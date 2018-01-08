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

extension UIView {
    func loadFromNibIfEmbeddedInDifferentNib() -> Self {
        let isJustAPlaceholder = subviews.count == 0
        if isJustAPlaceholder {
            let theRealThing = type(of: self).viewFromNib()
            theRealThing.frame = frame
            translatesAutoresizingMaskIntoConstraints = false
            theRealThing.translatesAutoresizingMaskIntoConstraints = false
            return theRealThing
        }
        return self
    }
    
    class func viewFromNib(withOwner owner: Any? = nil) -> Self {
        let name = String(describing: type(of:      self)).components(separatedBy: ".")[0]
        let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: owner, options: nil)[0]
        return cast(view)!
    }
}

private func cast<T, U>(_ value: T) -> U? {
    return value as? U
}

