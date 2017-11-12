//
//  MenuViewController.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/11/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class MenuViewController: CustomViewController {
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            playButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var rankingButton: UIButton! {
        didSet {
            rankingButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var exitButton: UIButton! {
        didSet {
            exitButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var musicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exitGame(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func shareApp(_ sender: Any) {

    }
    
    @IBAction func muteUnmuteMusic(_ sender: Any) {

    }
    
}
