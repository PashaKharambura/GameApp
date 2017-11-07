//
//  Board.swift
//  GameApp
//
//  Created by scales on 07.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class Dot: NSObject {
    enum DotType: Int {
        case border = 0
        case inside
        case outside
    }
    
    var type: DotType
    var active = true
    var connections = 0
    var index: Int
    
    init(type: DotType, index: Int) {
        self.type = type
        self.index = index
    }
    
    func get2DCoordinates() -> (row: Int, column: Int) {
        let row = index / 12
        let column = index % 12
        return (row, column)
    }
    
}

class Line: NSObject {
    var fromDot: Dot
    var toDot: Dot
    
    init(fromDot: Dot, toDot: Dot) {
        self.fromDot = fromDot
        self.toDot = toDot
    }
    
}

class Board: NSObject {

    static let width = 12
    static let height = 12
    
    private var dots = [Dot]()
    var borderLine = [Line]()
    
    init(levelString: String) {
        super.init()
        createDotsArray(from: levelString)
        createBorderLine()
    }
    
    func createDotsArray(from levelString: String) {
        for char in levelString {
            var elementType: Dot.DotType
            switch char {
            case "*": elementType = .border
            print("border")
            case ".": elementType = .outside
            print("outside")
            default: elementType = .inside
            print("inside")
            }
            dots.append(Dot(type: elementType, index: dots.count))
        }
    }
    
    func createBorderLine() {
        let borderDots = dots.filter { $0.type == .border }
        for borderDot in borderDots {
            if let dotToConnect = findClosestDot(to: borderDot) {
                connectTwoDost(borderDot, dotToConnect)
            }
        }
    }
    
    func connectTwoDost(_ firstDot: Dot, _ secondDot: Dot) {
        dots[firstDot.index].connections += 1
        dots[secondDot.index].connections += 1
        borderLine.append(Line(fromDot: firstDot, toDot: secondDot))
    }
    
    func findClosestDot(to dot: Dot) -> Dot? {
        let sameTypeDots = dots.filter { $0.type == dot.type && $0.connections == 0 && $0 != dot }
        
        let sortedDots = sameTypeDots.sorted { (first, second) -> Bool in
//            let firstColumn = first.get2DCoordinates().column - dot.get2DCoordinates().column
            
            
            
        }
        
        var resultDot = sameTypeDots.first
//        var minDisnance = 1000
//        for sameTypeDot in sameTypeDots {
//            let distanceTo = sameTypeDot.index - dot.index
//            if distanceTo < minDisnance {
//                resultDot = sameTypeDot
//                minDisnance = distanceTo
//            }
//        }
        
        return resultDot
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
