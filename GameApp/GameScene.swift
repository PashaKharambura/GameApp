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
    
    var board: Board!
    
    var delta = CGFloat()
    var startX = CGFloat()
    var startY = CGFloat()
    
    override func didMove(to view: SKView) {
        board = Board(levelString: Levels.lvl1)
        generateLevelBackground()
        createBorder()
    }
    
    func createDot(at position: CGPoint, and color: UIColor) {
        let dotNode = SKShapeNode(circleOfRadius: 3)
        let biggerDotNode = SKShapeNode(circleOfRadius: delta/2)
        
        dotNode.position = .zero
        dotNode.fillColor = color
        dotNode.strokeColor = color
        
        biggerDotNode.position = position
        
        biggerDotNode.addChild(dotNode)
        
        addChild(biggerDotNode)
    }
    
    func createBorder() {
        for line in board.borderLine {
            let path = CGMutablePath()
            let firstDotCoordinates = line.fromDot.get2DCoordinates()
            path.move(to: position(for: firstDotCoordinates.column, and: firstDotCoordinates.row))
            
            let secondDotCoordinates = line.toDot.get2DCoordinates()
            path.addLine(to: position(for: secondDotCoordinates.column, and: secondDotCoordinates.row))
         
            let lineNode = SKShapeNode(path: path)
            lineNode.fillColor = .black
            lineNode.strokeColor = .black
            lineNode.lineWidth = 4
            addChild(lineNode)
        }
        print("lines = ", board.borderLine.count)
    }
    
    func generateLevelBackground() {
        delta = ((scene?.frame.maxX)!)/CGFloat(Board.width)
        startX = delta/2
        startY = (scene?.frame.midY)! - CGFloat(Board.height)/2 * delta
        
        for (rowNumber, row) in board.getRows().enumerated() {
            for (colNumber, dot) in row.enumerated() {
                if dot.type != .outside {
                    var color: UIColor
                    if dot.type == .border {
                        color = .black
                    } else {
                        color = .gray
                    }
                    createDot(at: position(for: colNumber, and: rowNumber), and: color)
                }
            }
            
        }
    }
    
    func position(for column: Int, and row: Int) -> CGPoint {
        let x = startX + delta * CGFloat(column)
        let y = startY + delta * CGFloat(11 - row)
        return CGPoint(x: x, y: y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            let obj = atPoint(touch.location(in: self))
            if obj.children.count == 1 {
                let child = obj.children[0] as! SKShapeNode
                child.fillColor = .blue
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
