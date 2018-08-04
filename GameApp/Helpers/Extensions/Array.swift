//
//  Array.swift
//  GameApp
//
//  Created by Sergey Kletsov on 04.08.2018.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation

extension Array {
	subscript(safe index: Int) -> Element? {
		guard index < count - 1 else { return nil }
		return self[index]
	}
}
