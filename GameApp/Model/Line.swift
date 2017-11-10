//
//  Line.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/9/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import Foundation

class Line: NSObject {
    
    enum DiagonalType {
        case bottomTop
        case topBottom
        case none
    }
    
    var fromDot: Dot
    var toDot: Dot
    var diagonal: DiagonalType {
        switch angel {
        case 135.0: return .bottomTop
        case 45.0: return .topBottom
        default: return .none
        }
    }
    
    var angel: Double {
        return (atan2(Double((fromDot.column - toDot.column)), Double((fromDot.row - toDot.row))) / -Double.pi * 180) + 180
    }
    
    init(fromDot: Dot, toDot: Dot) {
        if fromDot.column < toDot.column {
            self.toDot = fromDot
            self.fromDot = toDot
        } else {
            self.fromDot = fromDot
            self.toDot = toDot
        }
    }
    
    func contains(dot: Dot) -> Bool {
        return fromDot == dot || toDot == dot
    }
    
    func getConnectedDot(dot: Dot) -> Dot {
        return fromDot == dot ? toDot : fromDot
    }
    
}
