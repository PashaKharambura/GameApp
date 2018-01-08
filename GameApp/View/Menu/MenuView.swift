//
//  MenuView.swift
//  GameApp
//
//  Created by scales on 07.01.2018.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

@IBDesignable class MenuView: UIView {

    var contentView: UIView?
    
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
        
        contentView!.frame = bounds
        
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        addSubview(contentView!)
        contentView!.layer.zPosition = 10
    }
    
    func loadFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Menu", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
//        print(nib.instantiate(withOwner: self, options: nil))
        
        return view
    }
    
}
