//
//  Player.swift
//  GameApp
//
//  Created by scales on 22.11.2017.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class Player: NSObject {

    var color: String
    var score = 0
    
    var opponent: Player {
        if color == "blue" {
            return Player.allPlayers[1]
        } else {
            return Player.allPlayers[0]
        }
    }
    
    static let allPlayers = [Player(color: "blue"), Player(color: "red")]
    
    private init(color: String) {
        self.color = color
        
        super.init()
    }
    
}
