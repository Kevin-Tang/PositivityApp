//
//  ViewController.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/6/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count: Int = 0
    
    //MARK: Properties
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = String(count)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func incrementCount(_ sender: UIButton) {
        count += 1
        countLabel.text = String(count)
    }
}
