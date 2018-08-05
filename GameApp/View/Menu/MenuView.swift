//
//  MenuView.swift
//  GameApp
//
//  Created by scales on 07.01.2018.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

@IBDesignable class MenuView: UIView {

    var contentView: UIView!
    
	var buttons: [MenuButton]! {
        return stackView.subviews.filter { $0 is MenuButton } as? [MenuButton]
    }
	
	var stackView: UIStackView! {
		return contentView.subviews.first(where: { $0 is UIStackView }) as? UIStackView
	}
    
    static var allMenuViews: [UIView]! {
        let bundle = Bundle(for: MenuView.self)
        let nib = UINib(nibName: "Menu", bundle: bundle)
        let views = nib.instantiate(withOwner: MenuView.self) as? [UIView]
        views?.forEach { $0.backgroundColor = .clear }
        
        return views
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
        contentView?.prepareForInterfaceBuilder()
    }

    func setupView() {
        contentView = loadFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
		
		contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		contentView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
		
		stackView.spacing = Constants.Grid.cellSize
    }
    
    func loadFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Menu", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view
    }
    
}
