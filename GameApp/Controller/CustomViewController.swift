//
//  CustomViewController.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/12/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
    }

}
