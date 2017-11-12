//
//  GameScene.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/7/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, BoardDelegate {
    let brightBlue = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 0.3)

    var dotNodes = [DotNode]()
    var availableDots: [DotNode]?
    
    var board: Board!
    
    var delta = CGFloat()
    var startX = CGFloat()
    var startY = CGFloat()
    
    var selectedDot: DotNode?
    var gVC = GameViewController()
    
    override func didMove(to view: SKView) {
        board = Board(levelString: Levels.levels[LevelNumber.instanse.index])
        board.delegate = self
        generateLevelBackground()
        createBorder()
        createGrid()
    }
    
    // Make and paint background grid
    
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
    
    // Draw border lines
    
    func createBorder() {
        for line in board.lines {
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
    
    // Make field dots
    
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
    
    // Draw figure
    
    func handleNewFigure(_ figure: Figure) {
        var dotNodes = getNodesFrom(dots: figure.dots)
        print("got an \(figure.type)")
        
        let path = UIBezierPath()
        path.move(to: dotNodes.removeFirst().tapArea.position)
        dotNodes.forEach { path.addLine(to: $0.tapArea.position) }
        path.close()
        
        let triangleNode = SKShapeNode(path: path.cgPath)
        triangleNode.fillColor = .black
        triangleNode.strokeColor = .black
        
        addChild(triangleNode)
    }
    
    // Get position from column&row
    
    func position(for column: Int, and row: Int) -> CGPoint {
        let x = startX + delta * CGFloat(column)
        let y = startY + delta * CGFloat(11 - row)
        return CGPoint(x: x, y: y)
    }

    // Touches processing
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch1 = touches.first {
            if let obj = atPoint(touch1.location(in: self)) as? SKShapeNode {
                if let dotNode = getDotNodeFrom(shapeNode: obj) {

                    if selectedDot == nil { // first dot tap
                        selectedDot = dotNode
                        fillAvailableDotsFrom(dots: board.getDotsNear(dot: board.dots[dotNode.index]), callback: showMoves)
                    } else { // second dot tap or diselect
                        let secondDot = dotNode
                        if availableDots!.contains(secondDot) {
                            board.connectTwoDost(board.dots[selectedDot!.index], board.dots[secondDot.index])
                            drawLine(from: selectedDot!.tapArea.position, to: secondDot.tapArea.position, with: .black, and: 3)
                        }
                        selectedDot = nil
                        hideMoves()
                    }
                }
            } else {
                selectedDot = nil
                hideMoves()
            }
        }
    }
    
    func getDotNodeFrom(shapeNode: SKShapeNode) -> DotNode? {
        return dotNodes.first { $0.tapArea == shapeNode || $0.visibleDot == shapeNode }
    }

    // Make array of available dots for connecting with selected dot
    
    func fillAvailableDotsFrom(dots: [Dot], callback: @escaping ()->()) {
        availableDots = getNodesFrom(dots: dots)
        callback()
    }
    
    func getNodesFrom(dots: [Dot]) -> [DotNode] {
        return dots.map({ (dot) -> DotNode in
            dotNodes.first { $0.index == dot.index }!
        })
    }
    
    func showMoves() {
        availableDots?.forEach { $0.zoomIn() }
    }
    
    func hideMoves() {
        availableDots?.forEach { $0.zoomOut() }
        availableDots = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}
