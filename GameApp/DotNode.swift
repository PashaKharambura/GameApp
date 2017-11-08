//
//  DotNode.swift
//  GameApp
//
//  Created by scales on 08.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit
import SpriteKit

class DotNode: NSObject {
    var index: Int
    var visibleDot: SKShapeNode
    var tapArea: SKShapeNode
    
    init(circleOfRadius radius: CGFloat, at position: CGPoint, and color: UIColor, tapAreaRaduis: CGFloat, index: Int) {
        visibleDot = SKShapeNode(circleOfRadius: radius)
        tapArea = SKShapeNode(circleOfRadius: tapAreaRaduis)
        
        visibleDot.position = .zero
        visibleDot.fillColor = color
        visibleDot.strokeColor = color
        visibleDot.name = "visibleDot"
        
        tapArea.position = position
        tapArea.name = "tapArea"
        tapArea.zPosition = 999
        tapArea.strokeColor = .clear
        
        tapArea.addChild(visibleDot)
        
        self.index = index
    }
    
    func zoomIn() {
        visibleDot.run(SKAction.scale(by: 2, duration: 0.5))
    }
    
    func zoomOut() {
        visibleDot.run(SKAction.scale(by: 0.5, duration: 0.5))
    }
}
