//
//  Board.swift
//  GameApp
//
//  Created by scales on 07.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class Dot {
    enum DotType: Int {
        case border = 0
        case inside
        case outside
    }
    
    var type: DotType
    var active = true
    
    init(type: DotType) {
        self.type = type
    }
    
}

class Board: NSObject {

    static let width = 12
    static let height = 12
    
    private var dots = [Dot]()
    
    init(levelString: String) {
        for char in levelString {
            var element: Dot
            switch char {
            case "*": element = Dot(type: .border)
                print("border")
            case ".": element = Dot(type: .outside)
                print("outside")
            default: element = Dot(type: .inside)
                print("inside")
            }
            dots.append(element)
        }
    }
    
    func getRows() -> [[Dot]] {
        var result = [[Dot]]()
        
        for i in 0..<12 {
            var row = [Dot]()
            
            for j in 0..<12 {
                row.append(dots[i * 12 + j])
            }
            
            result.append(row)
        }
        
        
        
        return result
    }
    
    
}
