//
//  Figure.swift
//  GameApp
//
//  Created by scales on 12.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class Figure: NSObject {
    // MARK: enum
    /// Types of possible figures
    /// rawValue for points
    enum FigureType: Int {
        case triangle = 5
        case bigTriangle = 20
        case square = 10
        case rhombus = 40
        case parallelogram = 15
    }
    // MARK: open properties
    // type: optional, have type only when figure is finished
    // dots: contains all dots that figure have. Dots dosent repeat.
    var type: FigureType?
    var dots: [Dot]
    
    // MARK: private properties
    // all are used in the process of creating figure. after its done they gone too (= nil)
    private var lines: [Line]?
    private var perimeter: Double? = 0.0
    private var diagonalAngleSumm: Double? = 0.0
    
    
    /// Initializer
    ///
    /// - Parameter line: init accept first line, adds both dots from line to dots array, and use handleNewLine method.
    init(line: Line) {
        self.lines = [line]
        dots = [line.fromDot]
        dots.append(line.toDot)
        super.init()
        handleNewLine(line: line)
        }
    
    /// Adds new line to figure.
    /// Method adds only new dots to dots array, and use handleNewLine method.
    /// - Parameter line: Line to add.
    func add(line: Line) {
        if !dots.contains(where: { $0 == line.toDot }) {
            dots.append(line.toDot)
        }
        if !dots.contains(where: { $0 == line.fromDot }) {
            dots.append(line.fromDot)
        }
        handleNewLine(line: line)
    }
    
    /// Finish creating figure. After user uses this method it is trying to find and recognize figure.
    ///
    /// - Returns: true if figure was found, false if wasnt
    func finishFigure() -> Bool {
        setType()
        
        // figure is finished, cleaning properties
        if type != nil {
            perimeter = nil
            diagonalAngleSumm = nil
            lines = nil
            sortDots()
            return true
        }
        return false
    }
    
    /// Adds line's lenght to perimeter and diagonal angle to diagonal angle summ.
    ///
    /// - Parameter line: line to take lengh and diagonal angle
    private func handleNewLine(line: Line) {
        perimeter! += line.lenght
        diagonalAngleSumm! += line.diagonal != .none ? line.angel : 0
    }
    
    /// Trying to set type of figure based on perimeter (triangle, square, rhombus) or diagonal angle summ (bigTriangle, parallelogram). If it fails, type stays nil
    private func setType() {
        switch perimeter! {
        case 3.4:
            type = .triangle
        case 4:
            type = .square
        case 4.8:
            if diagonalAngleSumm == 180 {
                type = .bigTriangle
            } else {
                type = .parallelogram
            }
        case 5.6:
            type = .rhombus
        default:
            break
        }
    }
    
    /// Sorts dots array after figure is ready, so every dot in array is connected to next dot in array. Last dot is connected to first.
    private func sortDots() {
        var sorted = [dots[0]]
        let copyDots = Array(dots.dropFirst())
        var helperDots = [Dot]()
        
        for dot in dots {
            print(dot.description)
        }
        
        for dot in copyDots {
            if dot.isConnected(to: sorted.last!) {
                sorted.append(dot)
            } else {
                for helperDot in helperDots {
                    if helperDot.isConnected(to: sorted.last!) {
                        sorted.append(helperDot)
                    }
                }
                helperDots.append(dot)
            }
        }
        
        if let lastDot = helperDots.first {
            sorted.append(lastDot)
        }
        
        for dot in sorted {
            print(dot.description)
        }
        
        self.dots = sorted
    }
    
}
