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
    //@IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var webViewBG: UIWebView!
    
    //let imageArray: [String] = ["city", "clouds", "colors", "hello", "love", "marble", "mountains", "panda", "rainbow", "red", "robot"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let htmlPath = Bundle.main.path(forResource: "WebView", ofType: "html")
        let htmlURL = URL(fileURLWithPath: htmlPath!)
        let html = NSData(contentsOf: htmlURL)
        
        self.webViewBG.load(html as! Data, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: htmlURL.deletingLastPathComponent())
        
        
        /*
        // Round Buttons
        continueButton.layer.cornerRadius = 6
        aboutButton.layer.cornerRadius = 6
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*
        let imageIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
        bgImage.image = UIImage(named: imageArray[imageIndex])
         */
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
