//
//  SelectLevelViewController.swift
//  GameApp
//
//  Created by Pavlo Kharambura on 11/12/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

class SelectLevelViewController: CustomViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var levelCollectionView: UICollectionView! {
        didSet {
            levelCollectionView.delegate = self
            levelCollectionView.dataSource = self
        }
    }
    
    let levelsArray = Levels.levels
    
    var gameMode = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levelsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = levelCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! LevelCollectionViewCell
        cell.levelLabel.text = "level \(indexPath.row + 1)"
        cell.levelImage.image = UIImage(named: "\(indexPath.row + 1)")
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let index = levelCollectionView.indexPath(for: cell)!.row
        let nextVC = segue.destination as! GameViewController
        nextVC.gameMode = gameMode
        LevelNumber.instanse.index = index
    }

    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
