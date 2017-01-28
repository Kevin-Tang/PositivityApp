//
//  DetailViewController.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/10/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet var detailMessageLabel: UILabel!
    @IBOutlet var detailDateLabel: UILabel!
    @IBOutlet var detailCountLabel: UILabel!
    
    var messageLine = String()
    var dateLine = String()
    var countLine: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        // Set labels off screen
        detailMessageLabel.alpha = 0.0
        detailDateLabel.center.x -= view.bounds.width
        detailCountLabel.center.x -= view.bounds.width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Set label texts from table cell
        detailMessageLabel.text = messageLine
        detailDateLabel.text = dateLine
        detailCountLabel.text = "Positive Streak of this Entry: " + String(countLine) + "!!!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animates the labels onto the screen
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.detailMessageLabel.alpha = 1
            self.detailDateLabel.center.x += self.view.bounds.width
            self.detailCountLabel.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    //MARK: Actions
    
    // This function creates a share button to share the journal entry
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        // Text to share
        let text = "My Positive Moment I just tracked is " + messageLine + " and my Positive Streak is " + String(countLine) + "!!!"
        
        // Set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // Exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = []
        
        // Present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    

}
