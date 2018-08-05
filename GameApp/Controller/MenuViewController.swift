//
//  MenuViewController.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/11/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class MenuViewController: CustomViewController {
    @IBOutlet private weak var menuView: MenuView!
	@IBOutlet private weak var menuWidth: NSLayoutConstraint!
	private var menuViewsContent = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		menuWidth.constant = Constants.cellSize*9
        menuViewsContent.append(menuView.contentView)
        menuView.buttons.forEach { $0.addTarget(self, action: #selector(MenuViewController.buttonTapped), for: .touchUpInside) }
    }
    
    private func presentMenuView(_ newMenuView: UIView) {
        guard let prevView = menuViewsContent.last else { return }
        menuView.addSubview(newMenuView)
		addBackButtonTo(menuView: newMenuView)
        let deltaX = view.frame.maxX
		newMenuView.frame = CGRect(x: deltaX,
								   y: prevView.frame.origin.y,
								   width: prevView.frame.width,
								   height: prevView.frame.height)
		UIView.animate(withDuration: 0.5, animations: {
            prevView.transform = CGAffineTransform(translationX: -deltaX, y: 0)
            newMenuView.transform = CGAffineTransform(translationX: -deltaX, y: 0)
		}, completion: { _ in
			self.menuViewsContent.append(newMenuView)
		})
    }
	
	private func addBackButtonTo( menuView: UIView) {
		guard let lastMenuButton = menuView.subviews
			.sorted(by: { $0.frame.origin.y > $1.frame.origin.y })
			.first else { return }
		let backButton = MenuButton(frame: lastMenuButton.bounds)
		backButton.setTitle("Back", for: .normal)
		menuView.addSubview(backButton)
		
		backButton.translatesAutoresizingMaskIntoConstraints = false
		backButton.heightAnchor.constraint(equalTo: lastMenuButton.heightAnchor).isActive = true
		backButton.leftAnchor.constraint(equalTo: lastMenuButton.leftAnchor).isActive = true
		backButton.rightAnchor.constraint(equalTo: lastMenuButton.rightAnchor).isActive = true
		backButton.topAnchor.constraint(equalTo: lastMenuButton.bottomAnchor, constant: 30).isActive = true
		
		backButton.addTarget(self, action: #selector(MenuViewController.backButtonTapped), for: .touchUpInside)
	}
	
	@objc func buttonTapped(sender: UIButton) {
		guard let selectedMenu = MenuView.allMenuViews.first(where: {
			$0.restorationIdentifier == sender.titleLabel?.text?.lowercased()
		}) else {
			print("cannot find selected menu")
			return
		}
		presentMenuView(selectedMenu)
	}
	
	@objc func backButtonTapped(sender: UIButton) {
		guard
			let currentMenuView = menuViewsContent.last,
			let prevMenuView = menuViewsContent[safe: menuViewsContent.count - 2] else { return }
		UIView.animate(withDuration: 0.5, animations: {
			currentMenuView.transform = .identity
			prevMenuView.transform = .identity
		}, completion: { _ in
			currentMenuView.removeFromSuperview()
			self.menuViewsContent.removeLast()
		})
	}
    
}
