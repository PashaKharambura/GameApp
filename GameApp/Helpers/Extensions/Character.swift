//
//  Character.swift
//  GameApp
//
//  Created by scales on 09.04.2018.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

extension Character {
	var code: Int {
		return Int(self.unicodeScalars.first?.value ?? 0)
	}
}
