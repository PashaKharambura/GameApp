//
//  MenuViewController.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/11/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class MenuViewController: CustomViewController {
    @IBOutlet weak var menuView: MenuView!
    var menuViewsContent = [UIView?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuViewsContent.append(menuView.contentView)
        menuView.buttons.forEach { $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside) }
    }    

    @objc func buttonTapped(sender: UIButton) {
        for menuView in MenuView.allMenuViews {
            if menuView.restorationIdentifier! == sender.titleLabel!.text!.lowercased() {
                presentMenuView(menuView)
                return
            }
        }
    }
    
    func presentMenuView(_ newMenuView: UIView) {
        guard let prevView = menuViewsContent.last else { return }
        menuView.addSubview(newMenuView)
        let deltaX = view.frame.maxX
        newMenuView.center = CGPoint(x: prevView!.center.x + deltaX, y: prevView!.center.y)
        UIView.animate(withDuration: 0.5) {
            prevView?.center.x -= deltaX
            newMenuView.center.x -= deltaX
        }
    }
    
}
