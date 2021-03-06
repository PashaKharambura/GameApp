//
//  CGPath.swift
//  GameApp
//
//  Created by scales on 09.04.2018.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

extension CGPath {
	static func getBoardGrid() -> CGPath {
		let result = UIBezierPath()
		let delta = Constants.Grid.cellSize
		let startX = Constants.Grid.firstLineX
		let startY = Constants.Grid.firstLineY
		
		// vertical
		for i in 0..<Constants.Board.width {
			let startPoint = CGPoint(x: startX + CGFloat(i) * delta, y: 0)
			let finishPoint = CGPoint(x: startX + CGFloat(i) * delta, y: UIScreen.main.bounds.height)
			
			result.move(to: startPoint)
			result.addLine(to: finishPoint)
		}
		
		// horizontal
		for i in 0..<Int(UIScreen.main.bounds.height/delta) {
			let startPoint = CGPoint(x: 0, y: startY + CGFloat(i) * delta)
			let finishPoint = CGPoint(x: UIScreen.main.bounds.width, y: startY + CGFloat(i) * delta)
			
			result.move(to: startPoint)
			result.addLine(to: finishPoint)
		}
		
		return result.cgPath
	}
}
