//
//  Figure.swift
//  GameApp
//
//  Created by scales on 12.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class Figure: NSObject {
    
    // rawValue for points
    enum FigureType: Int {
        case triangle = 5
        case bigTriangle = 20
        case square = 10
        case rhombus = 40
        case parallelogram = 15
    }
    
    var dots: [Dot]
    var type: FigureType
    var perimeter = 0.0
    
    init(lines: [Line]) {
        self.dots = Figure.getUniqueDotsFrom(lines: lines)
        for line in lines {
            perimeter += line.lenght
        }
        
        switch perimeter {
        case 3.4:
            type = .triangle
        case 4:
            type = .square
        case 5.6:
            type = .rhombus
        default:
            var angelSumm = 0.0
            lines.forEach { if $0.diagonal != .none { angelSumm += $0.angel } }
            if angelSumm == 180 {
                type = .bigTriangle
            } else {
                type = .parallelogram
            }
        }
        
        super.init()
    }
    
    static func getUniqueDotsFrom(lines: [Line]) -> [Dot] {
        var result = [Dot]()
        
        for line in lines {
            if !result.contains(where: { $0 == line.toDot }) {
                result.append(line.toDot)
            }
            if !result.contains(where: { $0 == line.fromDot }) {
                result.append(line.fromDot)
            }
        }
        
        return result
    }
    
}
