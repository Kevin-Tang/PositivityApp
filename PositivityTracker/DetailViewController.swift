//
//  DetailViewController.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/10/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var messageLine = String()
    var dateLine = String()
    var countLine: Int = 0
    
    //MARK: Properties
    @IBOutlet var detailMessageLabel: UILabel!
    @IBOutlet var detailDateLabel: UILabel!
    @IBOutlet var detailCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailMessageLabel.text = messageLine
        detailDateLabel.text = dateLine
        detailCountLabel.text = "Positive Streak of this Entry: " + String(countLine) + "!!!"
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
