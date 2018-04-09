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
	
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}
    
    private func setupView() {
        layer.cornerRadius = 20
		bounds.size = CGSize(width: 200, height: 40)
		titleLabel?.font = UIFont(name: fontName, size: fontSize)!
        backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        setTitleColor(.white, for: .normal)
    }
}
