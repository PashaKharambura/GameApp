//
//  GameModeViewController.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/11/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class GameModeViewController: UIViewController {

    @IBOutlet weak var playWithBot: UIButton! {
        didSet {
            playWithBot.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var playWithFriend: UIButton! {
        didSet {
            playWithFriend.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var playWithAnotherUser: UIButton! {
        didSet {
            playWithAnotherUser.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var musicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
}
