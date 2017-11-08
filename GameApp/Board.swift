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
    var active = false {
        didSet {
            if type == .border {
                active = oldValue
            }
        }
    }
    
    var connections = 0
    var index: Int
    
    init(type: DotType, index: Int, char: Character) {
        self.type = type
        self.index = index
        self.char = char
        super.init()
        self.active = true
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
    private var borderDots = [Dot]()
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
    
    func haveNext(dot: Dot) -> Dot? {
        if dot.get2DCoordinates().column < 11 {
            if dots[dot.index + 1].type == .border {
                return dots[dot.index + 1]
            }
        }
        
        return nil
    }
    
    func haveBottom(dot: Dot) -> Dot? {
        if dot.get2DCoordinates().row < 11 {
            if dots[dot.index + 12].type == .border {
                return dots[dot.index + 12]
            }
        }
        
        return nil
    }
    
    func haveDiagonal(dot: Dot) -> Dot? {
        if dot.get2DCoordinates().column < 11 && dot.get2DCoordinates().row < 11 {
            if dots[dot.index + 13].type == .border {
                return dots[dot.index + 13]
            } else if dots[dot.index + 11].type == .border {
                return dots[dot.index + 11]
            }
        }
        
        return nil
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

extension Character {
    var code: Int {
        
        return Int(self.unicodeScalars.first?.value ?? 0)
    }
    
    static var startCode: Int {
        return 48
    }
}
