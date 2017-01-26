//
//  HomeViewController.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/24/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    let imageArray: [String] = ["city", "clouds", "colors", "hello", "love", "marble", "mountains", "panda", "rainbow", "red", "robot"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round Buttons
        continueButton.layer.cornerRadius = 6
        aboutButton.layer.cornerRadius = 6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let imageIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
        bgImage.image = UIImage(named: imageArray[imageIndex])
    }
}
