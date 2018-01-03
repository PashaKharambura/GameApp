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
    
//    var player1: SKLabelNode!
//    var p1Score: SKLabelNode? {
//        if let p1Scr = player1. {
//            return p1Scr
//        }
//
//        return nil
//    }
//    var p1Line: SKSpriteNode!
    
//    var player2: SKLabelNode!
//    var p2Score: SKLabelNode? {
//        if let p2Scr = player2.childNode(withName: "Score") as? SKLabelNode {
//            return p2Scr
//        }
//
//        return nil
//    }
//    var p2Line: SKSpriteNode!
    
    var playersInfo = [PlayerInfo]()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupLabels()
        drewColor = board.currentPlayer.drewColor
    }
    
    func activePlayerInfo() -> PlayerInfo {
        if playersInfo[1].hasName(board.currentPlayer.name) {
            return playersInfo[1]
        } else {
            return playersInfo[0]
        }
    }
    
    func setupLabels() {
        let p1Name = self.childNode(withName: "Player1") as! SKLabelNode
        let p2Name = self.childNode(withName: "Player2") as! SKLabelNode
        
        playersInfo = [PlayerInfo(nameLabel: p1Name), PlayerInfo(nameLabel: p2Name)]
        playersInfo[1].line.isHidden = true
    }
    
    func swapActivePlayer() {
        activePlayerInfo().line.isHidden = true
        board.currentPlayer = board.currentPlayer.opponent
        activePlayerInfo().line.isHidden = false
        
        drewColor = board.currentPlayer.drewColor
        
//        if p1Line.isHidden {
//            p1Line.isHidden = false
//            p2Line.isHidden = true
//            drewColor = .blue
//        } else {
//            p1Line.isHidden = true
//            p2Line.isHidden = false
//            drewColor = .red
//        }
    }
    
    override func handleNewFigure(_ figure: Figure) {
        super.handleNewFigure(figure)
        
//        swapActivePlayer()
        board.currentPlayer.score += figure.type!.rawValue
//        if p2Line.isHidden {
//            let scoreToAddLabel = SKLabelNode(text: "+\(figure.type!.rawValue)")
//            scoreToAddLabel.fontName = p1Score!.fontName!
//            scoreToAddLabel.fontSize = p1Score!.fontSize
//            scoreToAddLabel.fontColor = p1Score!.fontColor!
////            scoreToAddLabel.position = p1Score?.frame.maxX
//            p1Score?.addChild(scoreToAddLabel)
//            p1Score?.text = "Score: \(board.currentPlayer.score)"
//        } else {
//            let scoreToAddLabel = SKLabelNode(text: "+\(figure.type!.rawValue)")
//            scoreToAddLabel.fontName = p2Score!.fontName!
//            scoreToAddLabel.fontSize = p2Score!.fontSize
//            scoreToAddLabel.fontColor = p2Score!.fontColor!
//            p2Score?.addChild(scoreToAddLabel)
//            p2Score?.text = "Score: \(board.currentPlayer.score)"
//        }
        activePlayerInfo().addScore(figure.type!.rawValue, totalScore: board.currentPlayer.score)
    }
    
    override func makeMove(to finishDot: DotNode) {
        super.makeMove(to: finishDot)
        swapActivePlayer()
    }
    
    
}
