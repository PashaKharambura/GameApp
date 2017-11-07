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
    
//    var dotsNodes = [SKShapeNode]()
    var board: Board!
    
    var delta = CGFloat()
    var startX = CGFloat()
    var startY = CGFloat()
    
    override func didMove(to view: SKView) {
        board = Board(levelString: Levels.lvl1)
        generateLevelBackground()
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
//        dotsNodes.append(dotNode)
    }
//
//    func createDots() {
//        let delta = ((scene?.frame.maxX)!)/10
//        let startX: CGFloat = delta/2
//        let startY = (scene?.frame.midY)! - 5 * delta
//
//        for x in 0..<10 {
//            for y in 0..<10 {
//                createDot(at: CGPoint(x: startX + delta * CGFloat(x), y: startY + delta * CGFloat(y)))
//            }
//        }
//    }
    
    func createBorder() {
        
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
                    createDot(at: CGPoint(x: startX + delta * CGFloat(colNumber), y: startY + delta * CGFloat(rowNumber)), and: color)
                }
            }
            
//            if char == "*" {
//                createDot(at: CGPoint(x: startX + delta * col, y: startY + delta * row))
//            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print((atPoint((touches.first?.location(in: self))!) as? SKShapeNode)?.fillColor)
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
