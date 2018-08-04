//
//  GameModeViewController.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/11/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class GameModeViewController: CustomViewController {

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

    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as? SelectLevelViewController
        nextVC?.gameMode = (sender as? UIButton)?.tag ?? 1
    }
    
}
