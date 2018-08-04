//
//  Constants.swift
//  GameApp
//
//  Created by scales on 09.04.2018.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//
import UIKit

enum Constants {
	static let boardWidth = 12
	static let boardHeight = 12
	static var cellSize: CGFloat {
		return (UIScreen.main.bounds.maxX)/CGFloat(Constants.boardWidth)
	}
}
