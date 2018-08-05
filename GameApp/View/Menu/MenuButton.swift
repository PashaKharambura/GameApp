//
//  MenuButton.swift
//  GameApp
//
//  Created by scales on 07.01.2018.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

@IBDesignable class MenuButton: UIButton {
	
	private var fontName: String = "Chalkduster"
	private var fontSize: CGFloat = 17
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupView()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}
	
	private func setupView() {
		heightAnchor.constraint(equalToConstant: Constants.cellSize).isActive = true
		layer.cornerRadius = Constants.cellSize/2
		titleLabel?.font = UIFont(name: fontName, size: fontSize)!
		backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
		setTitleColor(.white, for: .normal)
	}
	
}
