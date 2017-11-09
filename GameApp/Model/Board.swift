//
//  Board.swift
//  GameApp
//
//  Created by scales on 07.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import SpriteKit

class Dot: NSObject {
    enum DotType: Int {
        case border = 0
        case inside
        case outside
    }
    
    var char: Character
    var type: DotType
    
    var connections = [Dot]()
    var index: Int
    
    var column: Int {
        return index % 12
    }
    
    var row: Int {
        return index / 12
    }
    
    init(type: DotType, index: Int, char: Character) {
        self.type = type
        self.index = index
        self.char = char
        super.init()
    }

}

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
        case -45.0, 135.0: return .bottomTop
        case 45.0, -135.0: return .topBottom
        default: return .none
        }
    }
//
//    var reversedLine: (bottomColumn: Int, bottomRow: Int, topColumn: Int, topRow: Int)? {
//        switch diagonal {
//        case .bottomTop:
//            let pseudoLine = Line(fromDot: Dot(type: .inside, ), toDot: Dot(type: , index: <#T##Int#>, char: <#T##Character#>))
//            break
//        case .topBottom:
//            break
//        default: return nil
//        }
//    }
    
    var angel: Double {
        return atan2(Double((toDot.column - fromDot.column)), Double((toDot.row - fromDot.row))) / Double.pi * 180
    }
    
    
    init(fromDot: Dot, toDot: Dot) {
        if fromDot.column > toDot.column {
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

class Board: NSObject {

    static let width = 12
    static let height = 12
    
    var dots = [Dot]()
    var borderDots = [Dot]()
    var lines = [Line]()
    var figures = [Line]()
    
    init(levelString: String) {
        super.init()
        createDotsArray(from: levelString)
        createBorderLine()
    }
    
    func createDotsArray(from levelString: String) {
        for char in levelString {
            let index = dots.count
            var element: Dot
            switch char {
                case " ": element = Dot(type: .inside, index: index, char: char)
                case ".": element = Dot(type: .outside, index: index, char: char)
                default: element = Dot(type: .border, index: index, char: char)
                         borderDots.append(element)
            }
            dots.append(element)
        }
        borderDots = borderDots.sorted { $0.char.code < $1.char.code }
    }
    
    func getDotsNear(dot: Dot) -> [Dot] {
        var result = [Dot]()
        
        for i in -1...1 {
            for j in -1...1 {
                if let temp = haveDot(onColumn: dot.column + i, andRow: dot.row + j) {
                    if !temp.connections.contains(dot) {
                        result.append(temp)
                    }
                }
            }
        }
        return result.filter{ $0 != dot}
    }
    
    func lineIntersectAnotherLine(line: Line) -> Bool {
        if line.fromDot.column > line.toDot.column && line.fromDot.row < line.toDot.column {
            
        }
        
        return false
    }
    
//    func getLinesNear(dot: Dot) -> [Line] {
//        var result = [Line]()
//
////        for line in lines {
////
////        }
//        for i in -2...1 {
//            for j in -2...1 {
//                if let temp = haveDot(onColumn: dot.column + i, andRow: <#T##Int#>)
//                let filtredLines = lines.filter { $0.contains(dot: ) }
//            }
//
//        }
//
//        return result
//    }
    
//    
//    func getNodeWith(index: Int, dotNodes: [DotNode]) -> DotNode {
//        return dotNodes.first { $0.index == index }!
//    }
    
    func createBorderLine() {
        for (index, borderDot) in borderDots.enumerated() {
            var dotToConnect: Dot
            if index == borderDots.count - 1 {
                dotToConnect = borderDots[0]
            } else {
                dotToConnect = borderDots[index + 1]
            }
            connectTwoDost(borderDot, dotToConnect)
        }
    }
    
    func connectTwoDost(_ firstDot: Dot, _ secondDot: Dot) {
        dots[firstDot.index].connections.append(secondDot)
        dots[secondDot.index].connections.append(firstDot)
        
        let line = Line(fromDot: firstDot, toDot: secondDot)
        lines.append(line)
        if lines.count > 40 {
            print(line.diagonal)
            print(line.angel)
            analizeFigures(from: firstDot, to: secondDot)
        }
    }
    
    func analizeFigures(from startDot: Dot, to finishDot: Dot) {
        print(finishDot.connections.count)
        print(startDot.connections.count)
        if startDot.connections.count >= 2 && finishDot.connections.count >= 2 {
            print("finding figure")
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
    
    func haveDot(onColumn col: Int, andRow row: Int) -> Dot? {
        return dots.first(where: { $0.row == row && $0.column == col && $0.type != .outside })
    }
}



extension Character {
    var code: Int {
        return Int(self.unicodeScalars.first?.value ?? 0)
    }
}
