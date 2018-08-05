//
//  Constants.swift
//  GameApp
//
//  Created by scales on 09.04.2018.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//
import UIKit

enum Constants {
	enum Board {
		static let width = 12
		static let height = 12
	}
	
	enum Grid {
		static var firstLineX: CGFloat {
			return cellSize/2
		}
		static var firstLineY: CGFloat {
			let startY = (UIScreen.main.bounds.midY) - CGFloat(Constants.Board.height)/2 * cellSize
			let result = startY - CGFloat(Int((startY/cellSize))) * cellSize
			return result
		}
		static var cellSize: CGFloat {
			return (UIScreen.main.bounds.maxX)/CGFloat(Constants.Board.width)
		}
	}
}
