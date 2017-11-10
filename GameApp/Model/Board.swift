//
//  Board.swift
//  GameApp
//
//  Created by scales on 07.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import SpriteKit

class Board: NSObject {

    static let width = 12
    static let height = 12
    
    var dots = [Dot]()
    var borderDots = [Dot]()
    var lines = Set<Line>()
    var figures = [Line]()
    
    init(levelString: String) {
        super.init()
        createDotsArray(from: levelString)
        createBorderLine()
    }
    
    // Cteate all dots array and border dots array with sorting by clockwise
    
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
    
    // Check if array of all lines have line with two dots
    
    func containLine(with dot1: Dot, and dot2: Dot) -> Bool {
        if (lines.contains { $0.fromDot.index == dot1.index && $0.toDot.index == dot2.index} || lines.contains { $0.toDot.index == dot1.index && $0.fromDot.index == dot2.index} ) {
            return true
        } else {
            return false
        }
    }
    
    // Find dots which can be connected with selected dot
    
    func getDotsNear(dot: Dot) -> [Dot] {
        var result = [Dot]()
        
        for i in -1...1 {
            for j in -1...1 {
                if let temp = haveDot(onColumn: dot.column + i, andRow: dot.row + j) {
                    if !temp.connections.contains(dot) {
                        
                        if !( (i + j == 2 || i + j == 0 || i + j == -2) && (containLine(with: haveDot(onColumn: dot.column + i, andRow: dot.row)!, and: haveDot(onColumn: dot.column, andRow: dot.row + j)!)) ) {
                            result.insert(temp, at: 0)
                         }
                    }
                }
            }
        }
        return result.filter{ $0 != dot}
    }
    
    // Not forgot to write!
    
    func lineIntersectAnotherLine(line: Line) -> Bool {
        if line.fromDot.column > line.toDot.column && line.fromDot.row < line.toDot.column {
            
        }
        
        return false
    }
    
    // Create border
    
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
    
    // Connecting 2 dots and analysing figure later...
    
    func connectTwoDost(_ firstDot: Dot, _ secondDot: Dot) {
        dots[firstDot.index].connections.append(secondDot)
        dots[secondDot.index].connections.append(firstDot)
        
        let line = Line(fromDot: firstDot, toDot: secondDot)
        lines.insert(line)
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
    
    // Return dot with column&row
    
    func haveDot(onColumn col: Int, andRow row: Int) -> Dot? {
        return dots.first(where: { $0.row == row && $0.column == col && $0.type != .outside })
    }
}
