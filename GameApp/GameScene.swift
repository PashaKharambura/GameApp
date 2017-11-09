//
//  GameScene.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/7/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let brightBlue = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 0.3)
    
    var firstDot = Dot(type: .border, index: 1, char: "0")
    var secondDot = Dot(type: .border, index: 1, char: "0")
    var touched:Bool = false

    var board: Board!
    
    var delta = CGFloat()
    var startX = CGFloat()
    var startY = CGFloat()
    
    var selectedDot: DotNode? = nil {
        willSet {
            if newValue == nil  {
                hideMoves()
            }
        }
        
        didSet {
            if oldValue == nil {
                showMoves()
            }
        }
    }
    
    var dotNodes = [DotNode]()
    
    override func didMove(to view: SKView) {
        board = Board(levelString: Levels.lvl2)
        generateLevelBackground()
        createBorder()
        createGrid()
    }
    
    func createGrid() {
        let screen = scene?.frame
        let newStartY = startY - CGFloat(Int((startY/delta)))*(delta)
        
        for i in 0..<Board.width {
            let fromPoint = CGPoint(x: startX + CGFloat(i)*delta, y: 0)
            let toPoint = CGPoint(x: startX + CGFloat(i)*delta , y: (screen?.height)!)
            
            // MARK: customise lines later!!!!!!!
            
            drawLine(from: fromPoint, to: toPoint, with: brightBlue, and: 1.0)
        }
        
        for j in 0..<Int((screen?.height)!/delta) {
            
            let fromPoint = CGPoint(x: 0, y: newStartY + CGFloat(j)*delta)
            let toPoint = CGPoint(x: (screen?.width)! , y: newStartY + CGFloat(j)*delta)
            
            drawLine(from: fromPoint, to: toPoint, with: brightBlue, and: 1.0)
        }
        
    }
    
    func createBorder() {
        for line in board.borderLine {
            let fromPos = position(for: line.fromDot.column, and: line.fromDot.row)
            let toPos = position(for: line.toDot.column, and: line.toDot.row)
            drawLine(from: fromPos, to: toPos, with: .black, and: 3)
        }
    }
    
    func drawLine(from startPosition: CGPoint, to endPosition: CGPoint, with color: UIColor, and width: CGFloat) {
        let path = CGMutablePath()
        path.move(to: startPosition)
        path.addLine(to: endPosition)
        let lineNode = SKShapeNode(path: path)
        lineNode.fillColor = color
        lineNode.strokeColor = color
        lineNode.lineWidth = width
        addChild(lineNode)
    }
    
    func generateLevelBackground() {
        delta = ((scene?.frame.maxX)!)/CGFloat(Board.width)
        startX = delta/2
        startY = (scene?.frame.midY)! - CGFloat(Board.height)/2 * delta
    
        for dot in board.dots {
            if dot.type != .outside {
                var color: UIColor
                if dot.type == .border {
                    color = .black
                } else {
                    color = .gray
                }
                let pos = position(for: dot.column, and: dot.row)
                let dotNode = DotNode(circleOfRadius: 3, at: pos, and: color, tapAreaRaduis: delta/2, index: dot.index)
                addChild(dotNode.tapArea)
                
                dotNodes.append(dotNode)
            }
        }
    }
    
    func position(for column: Int, and row: Int) -> CGPoint {
        let x = startX + delta * CGFloat(column)
        let y = startY + delta * CGFloat(11 - row)
        return CGPoint(x: x, y: y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch1 = touches.first {
            if let obj = atPoint(touch1.location(in: self)) as? SKShapeNode {
                if let dotNode = board.getDotNodeFrom(shapeNode: obj, dotNodes: dotNodes) {
                    print(dotNode.index)
                    if selectedDot == nil {
                        selectedDot = dotNode
                        firstDot = board.dots[dotNode.index]
                        print(firstDot.column, firstDot.row)
                        touched = true
                    } else {
                        secondDot = board.dots[dotNode.index]
                        print(secondDot.column, secondDot.row)
                        touched = false
                        selectedDot = nil
                    }
                }
            } else {
                selectedDot = nil
            }
            
        }
    }
    
    func showMoves() {
        board.getDotsNear(selected: selectedDot!, dotNodes: dotNodes).forEach( { $0.zoomIn() } )
    
    }
    
    func hideMoves() {
        board.getDotsNear(selected: selectedDot!, dotNodes: dotNodes).forEach( { $0.zoomOut() })
    }
    
    override func update(_ currentTime: TimeInterval) {
//
//        if (touched) {
//            board.connectTwoDost(firstDot, secondDot)
//        }
        
    }
    
}
