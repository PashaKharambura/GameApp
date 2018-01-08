//
//  MenuButton.swift
//  GameApp
//
//  Created by scales on 07.01.2018.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

@IBDesignable class MenuButton: UIButton {
    
    var fontName: String = "Chalkduster"
    var fontSize: CGFloat = 17
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = 20
        backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        setTitleColor(.white, for: .normal)
        frame.size = CGSize(width: 200, height: 40)
        titleLabel?.font = UIFont(name: fontName, size: fontSize)!
        self.setNeedsLayout()
    }
}
