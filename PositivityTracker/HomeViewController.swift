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
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let imageIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
        bgImage.image = UIImage(named: imageArray[imageIndex])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
