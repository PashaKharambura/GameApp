//
//  PlayerInfo.swift
//  GameApp
//
//  Created by scales on 03.01.2018.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerInfo: NSObject {
    
    var nameLabel: SKLabelNode
    var scoreLabel: SKLabelNode! {
        return nameLabel.childNode(withName: "Score") as? SKLabelNode
    }
    var line: SKSpriteNode! {
        return nameLabel.childNode(withName: "Line") as? SKSpriteNode
    }

    init(nameLabel: SKLabelNode) {
        self.nameLabel = nameLabel
    }
    
    func addScore(_ newValue: Int, totalScore: Int) {
        let scoreToAddLabel = SKLabelNode(text: "+\(newValue)")
        scoreToAddLabel.fontName = scoreLabel.fontName!
        scoreToAddLabel.fontSize = scoreLabel.fontSize
        scoreToAddLabel.fontColor = scoreLabel.fontColor!
        scoreToAddLabel.position = CGPoint(x: scoreLabel.frame.width + scoreToAddLabel.frame.width/2, y: 0)
        scoreToAddLabel.alpha = 0
        
        scoreLabel.addChild(scoreToAddLabel)
        
        let addScoreAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 1, duration: 0.25),
            SKAction.wait(forDuration: 1),
            SKAction.fadeAlpha(to: 0, duration: 0.25),
            SKAction.run { [unowned self] in
                scoreToAddLabel.removeFromParent()
                self.scoreLabel.text = "Score: \(totalScore)"
            }
        ])
        
        scoreToAddLabel.run(addScoreAction)
    }
    
    func hasName(_ name: String) -> Bool {
        return nameLabel.name == name
    }
}
