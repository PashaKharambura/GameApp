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
    
    var lenght: Double {
        switch diagonal {
        case .none: return 1
        default: return 1.4
        }
    }
    
    private var reversed: Line {
        return Line(fromDot: toDot, toDot: fromDot)
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
    
    func lineIsEqual(to line: Line) -> Bool {
        return self == line || self.reversed == line
    }
    
    override var description: String {
        return "fromDot = (\(fromDot.index)), toDot (\(toDot.index))"
    }
    
    static func == (lhs: Line, rhs: Line) -> Bool {
        return lhs.toDot == rhs.toDot && lhs.fromDot == rhs.fromDot
    }
    
}
