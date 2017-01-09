//
//  MainViewController.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/6/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate{
    
    //MARK: Properties
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var count: Int = 0
    var entry: JournalEntry?

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.delegate = self
        countLabel.text = String(count)
        dateLabel.text = getDate()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        messageLabel.text = textField.text
    }
    
    //MARK: Navigations
    
    
    //MARK: Actions
    @IBAction func incrementCount(_ sender: UIButton) {
        count += 1
        countLabel.text = "Positive Streak: " + String(count)
    }
    
    //MARK: Private Methods
    private func getDate() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        let dateReturned = dateFormatter.string(from: date as Date)
        return dateReturned
    }
}
