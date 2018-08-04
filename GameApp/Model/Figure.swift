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
    var cgRect: CGRect? {
        if type != nil {
            let minX = dots.map { $0.column }.min()!
            let minY = dots.map { $0.row }.min()!
            let maxX = dots.map { $0.column }.max()!
            let maxY = dots.map { $0.row }.max()!
            return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
        }
        return nil
    }
    
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
    
    /// Returns lines, that cannot be created after figure is finished.
    ///
    /// - Returns: Set of blocked lines
    func getBlockedLines() -> (Set<Line>, Int?) {
        var result = Set<Line>()
        var index: Int?
        if type != nil {
            switch type! {
            case .rhombus:
                let minRow = dots.map { $0.row }.min()!
                let minCol = dots.map { $0.column }.min()!
                let center = Dot(type: .inside, column: minCol + 1, row: minRow + 1, char: " ")
                index = center.index
                for dot in dots {
                    result.insert(Line(fromDot: center, toDot: dot))
                }
            case .bigTriangle, .parallelogram:
                if Line(fromDot: dots[0], toDot: dots[2]).lenght == 1 {
                    result.insert(Line(fromDot: dots[0], toDot: dots[2]))
                } else {
                    result.insert(Line(fromDot: dots[1], toDot: dots[3]))
                }
            case .square:
                result.insert(Line(fromDot: dots[0], toDot: dots[2]))
                result.insert(Line(fromDot: dots[1], toDot: dots[3]))
            default:
                break
            }
        }
        
        return (result, index)
    }
    
    /// Adds line's lenght to perimeter and diagonal angle to diagonal angle summ.
    ///
    /// - Parameter line: line to take lengh and diagonal angle
    private func handleNewLine(line: Line) {
        perimeter! += line.lenght
        diagonalAngleSumm! += line.diagonal != .none ? line.angel : 0
    }
	
	// swiftlint:disable:next line_length
	/// Trying to set type of figure based on perimeter (triangle, square, rhombus) or diagonal angle summ (bigTriangle, parallelogram). If it fails, type stays nil
    private func setType() {
        switch perimeter! {
        case Line.diagonalLenght + Line.straightLenght * 2:
            type = .triangle
        case Line.straightLenght * 4:
            type = .square
        case Line.diagonalLenght * 2 + Line.straightLenght * 2 :
            if diagonalAngleSumm == 180 {
                type = .bigTriangle
            } else {
                type = .parallelogram
            }
        case Line.diagonalLenght * 4:
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
        
        self.dots = sorted
    }
    
    func isIntersectsWith(figure: Figure) -> Bool {
        var selfDots = dots
        var comperableDots = figure.dots
        if figure.type! == .rhombus {
            let minRow = comperableDots.map { $0.row }.min()!
            let minCol = comperableDots.map { $0.column }.min()!
            let center = Dot(type: .inside, column: minCol + 1, row: minRow + 1, char: " ")
            comperableDots.append(center)
        } else if self.type! == .rhombus {
            let minRow = selfDots.map { $0.row }.min()!
            let minCol = selfDots.map { $0.column }.min()!
            let center = Dot(type: .inside, column: minCol + 1, row: minRow + 1, char: " ")
            selfDots.append(center)
        }
        let commonDots = selfDots.filter({ selfDot in
            comperableDots.contains(where: { $0 == selfDot })
        })
        return commonDots.count > 2
    }
    
}
