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
        // Set labels off screen
        detailMessageLabel.alpha = 0.0
        detailDateLabel.center.x -= view.bounds.width
        detailCountLabel.center.x -= view.bounds.width
        
        // Set label texts from table cell
        detailMessageLabel.text = messageLine
        detailDateLabel.text = dateLine
        detailCountLabel.text = "Positive Streak of this Entry: " + String(countLine) + "!!!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.detailMessageLabel.alpha = 1
            self.detailDateLabel.center.x += self.view.bounds.width
            self.detailCountLabel.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
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
    
    //MARK: Actions
    
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        // text to share
        let text = "My latest Positive Moment I just tracked: " + messageLine
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = []
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    

}
