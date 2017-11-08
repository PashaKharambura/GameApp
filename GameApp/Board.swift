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
    var char: Character
    var type: DotType
//    var active = false {
//        didSet {
//            if type == .border {
//                active = oldValue
//            }
//        }
//    }
    
    var connections = 0
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
//        self.active = true
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
    
    var dots = [Dot]()
    var borderDots = [Dot]()
    var borderLine = [Line]()
    
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
        dots[firstDot.index].connections += 1
        dots[secondDot.index].connections += 1
        borderLine.append(Line(fromDot: firstDot, toDot: secondDot))
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
