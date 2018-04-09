//
//  Board.swift
//  GameApp
//
//  Created by scales on 07.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import SpriteKit

/// ---
/// # Mehtods:
///     func handleNewFigures(_ figures: [Figure])
///     func handleFinish()
/// ---
protocol BoardDelegate {
    func handleNewFigures(_ figures: [Figure])
    func handleFinish()
}

class Board: NSObject {
    
    var delegate: BoardDelegate?
    
    var dots = [Dot]()
    var borderDots = [Dot]()
    var lines = Set<Line>()
    var figures = Set<Figure>()
    var blockedLines = Set<Line>()
    
    var currentPlayer: Player
    
    init(levelString: String) {
        currentPlayer = Player.allPlayers[0]
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
    
    func checkForEndGame() {
        print("Checking for end game")
        for dot in dots.filter({ $0.type != .outside }) {
            if dot.connections.count < 3 {
                return
            }
        }
        print(dots.map { $0.connections.count } )
        delegate?.handleFinish()
    }
    
    // Check if array of all lines have line with two dots
    
    func linesArrayContains(line: Line) -> Bool {
        return lines.contains(where: { $0 == line })
    }
    
    // Find dots which can be connected with selected dot
    
    func getDotsNear(dot: Dot) -> [Dot] {
        var result = [Dot]()
        
        for i in -1...1 {
            for j in -1...1 {
                if let temp = haveDot(onColumn: dot.column + i, andRow: dot.row + j) {
                    if !temp.connections.contains(dot) && !blockedLines.contains(where: { $0.isEqual(to: Line(fromDot: dot, toDot: temp)) }) {
                            result.insert(temp, at: 0)
                    }
                }
            }
        }
        return result.filter { $0 != dot && $0.type != .outside }
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
            if line.diagonal != .none {
                let mirrorLine = line.mirrorLine
                
                if dots.contains(where: { $0 == mirrorLine.fromDot } ) && dots.contains(where: { $0 == mirrorLine.toDot } ) {
                    blockedLines.insert(mirrorLine)
                }
            }
            if firstDot.connections.count >= 2 && secondDot.connections.count >= 2 {
                var figures = findFigures(previousDot: firstDot, tappedDot: secondDot)
                // filter figures, removing figures that intersects with existed figures
                figures = figures.filter { !isFigureIntersectsWithExistedFigures($0) }
                if figures.count != 0 { addFigures(figures) }
            }
//            analizeFigures(from: firstDot, to: secondDot)
        }
    }
    
//    func analizeFigures(from startDot: Dot, to finishDot: Dot) {
//        print(finishDot.connections.count)
//        print(startDot.connections.count)
//        if  {
//            print("finding figure")
//        }
//    }
    
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
        return dots.first(where: { $0.row == row && $0.column == col })
    }
    
    // Checking for figure 
    
    func findFigures(previousDot: Dot, tappedDot: Dot) -> [Figure] {
        let dotFirst = tappedDot
        let dotSecond = previousDot
        var figures = [Figure]()
        
        for dotThird in dotSecond.connections  {
            if dotThird.connections.count != 0 && !(dotThird == dotFirst) {
                for dotFourth in dotThird.connections {
                    if dotFourth.connections.count != 0 && !(dotFourth == dotSecond) {
                        if dotFourth == dotFirst {
//                            print("Малий трикутник!")
                            let figure = Figure(line: Line(fromDot: dotFirst, toDot: dotSecond))
                            figure.add(line: Line(fromDot: dotSecond, toDot: dotThird))
                            figure.add(line: Line(fromDot: dotThird, toDot: dotFirst))
                            if figure.finishFigure() {
                                figures.append(figure)
                            }
                        } else {
                            for dotFift in dotFourth.connections {
                                if dotFift == dotFirst {
//                                    print("Якийсь чотирикутник або великий трикутник!")
                                    let figure = Figure(line: Line(fromDot: dotFirst, toDot: dotSecond))
                                    figure.add(line: Line(fromDot: dotSecond, toDot: dotThird))
                                    figure.add(line: Line(fromDot: dotThird, toDot: dotFourth))
                                    figure.add(line: Line(fromDot: dotFourth, toDot: dotFirst))
                                    if figure.finishFigure() {
                                        figures.append(figure)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return figures
//        for (index, newFigure) in startedFigures.enumerated() {
//            print(newFigure.type)
//            if startedFigures.count > 1 {
//                if !figures.contains(where: { oldFigure in
//                    return oldFigure.isIntersectsWith(figure: newFigure)
//                }) {
//                    addFigure(newFigure)
//                    print("index = ", index)
//                    if index == startedFigures.count {
//                        checkForEndGame()
//                    }
//                }
//            } else {
//                addFigure(newFigure)
//            }
//        }
    }
    
    func isFigureIntersectsWithExistedFigures(_ figure: Figure) -> Bool {
        if figure.type! != .triangle  {
            let nearbyFigures = figures.filter({ figure.cgRect!.intersects($0.cgRect!) })
            if nearbyFigures.count > 0 {
                for nearbyFigure in nearbyFigures {
                    if figure.isIntersectsWith(figure: nearbyFigure) {
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    func addFigures(_ newFigures: [Figure]) {
        for newFigure in newFigures {
            figures.insert(newFigure)
            let newBlockedLines = newFigure.getBlockedLines()
            
            // adding blocked lines rom new figure to all blocked lines
            blockedLines.formUnion(newBlockedLines.0)
            
            // for rhombus adding connections to center dot to pass game finish
            if let centerIndex = newBlockedLines.1 {
                for dot in newFigure.dots {
                    dots[centerIndex].connections.append(dot)
                }
            }
            for dot in newFigure.dots {
                while dots[dot.index].connections.count < 3 {
                    dots[dot.index].connections.append(dots[dot.index])
                }
            }
        }
        delegate?.handleNewFigures(newFigures)
        checkForEndGame()
    }
    
}
