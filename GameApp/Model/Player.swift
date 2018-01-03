//
//  Player.swift
//  GameApp
//
//  Created by scales on 22.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class Player: NSObject {

    var name: String
    var color: String
    var score = 0
    
    var opponent: Player {
        if color == "blue" {
            return Player.allPlayers[1]
        } else {
            return Player.allPlayers[0]
        }
    }
    
    var drewColor: UIColor {
        return color == "blue" ? .blue : .red
    }
    
    static let allPlayers = [Player(color: "blue"), Player(color: "red")]
    
    private init(color: String) {
        self.color = color
        if color == "blue" {
            self.name = "Player1"
        } else {
            self.name = "Player2"
        }
        
        super.init()
    }
    
}
