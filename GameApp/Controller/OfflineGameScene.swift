//
//  OfflineGameScene.swift
//  GameApp
//
//  Created by scales on 22.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import SpriteKit

class OfflineGameScene: GameScene {
    
    var player1: SKLabelNode!
    var p1Score: SKLabelNode? {
        if let p1Scr = player1.childNode(withName: "Score") as? SKLabelNode {
            return p1Scr
        }
        
        return nil
    }
    var p1Line: SKSpriteNode!
    
    var player2: SKLabelNode!
    var p2Score: SKLabelNode? {
        if let p2Scr = player2.childNode(withName: "Score") as? SKLabelNode {
            return p2Scr
        }
        
        return nil
    }
    var p2Line: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupLabels()
        drewColor = UIColor.blue
    }
    
    func setupLabels() {
        player1 = self.childNode(withName: "Player1") as? SKLabelNode
        p1Score?.text = "Score: 0"
        p1Line = player1.childNode(withName: "Line") as? SKSpriteNode
        
        player2 = self.childNode(withName: "Player2") as? SKLabelNode
        p2Score?.text = "Score: 0"
        p2Line = player2.childNode(withName: "Line") as? SKSpriteNode
        p2Line.isHidden = true
    }
    
    func swapActivePlayer() {
        if p1Line.isHidden {
            p1Line.isHidden = false
            p2Line.isHidden = true
            drewColor = .blue
        } else {
            p1Line.isHidden = true
            p2Line.isHidden = false
            drewColor = .red
        }
    }
    
    override func handleNewFigure(_ figure: Figure) {
        super.handleNewFigure(figure)
        
        board.currentPlayer.score += figure.type!.rawValue
        if p2Line.isHidden {
            p1Score?.text = "Score: \(board.currentPlayer.score)"
        } else {
            p2Score?.text = "Score: \(board.currentPlayer.score)"
        }
    }
    
    override func makeMove(to finishDot: DotNode) {
        super.makeMove(to: finishDot)
        board.currentPlayer = board.currentPlayer.opponent
        swapActivePlayer()
    }
    
    
}
