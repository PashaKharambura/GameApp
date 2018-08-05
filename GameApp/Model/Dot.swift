//
//  Dot.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/9/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import Foundation

class Dot: NSObject {
    
    enum DotType: Int {
        case border = 0
        case inside
        case outside
    }
    
    var char: Character
    var type: DotType
    var connections = [Dot]()
    var index: Int
    
    var column: Int {
        return index % 12
    }
    var row: Int {
        return index / 12
    }
    
    init(type: DotType, index: Int, char: Character) {
        self.type = type
        self.index = index
        self.char = char
        super.init()
    }
    
    convenience init(type: DotType, column: Int, row: Int, char: Character) {
        self.init(type: type, index: row * Constants.Board.height + column, char: char)
    }
    
    func isConnected(to dot: Dot) -> Bool {
        return connections.contains(where: { $0 == dot })
    }
    
    static func == (lhs: Dot, rhs: Dot) -> Bool {
        return lhs.index == rhs.index
    }
    
    override var description: String {
        return "\(index)"
    }
}
