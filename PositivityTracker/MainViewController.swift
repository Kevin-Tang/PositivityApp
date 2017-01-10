//
//  MainViewController.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/6/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit
import os.log

class MainViewController: UIViewController, UITextFieldDelegate{
    
    //MARK: Properties
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addJournal: UIButton!
    
    var count: Int = 0
    var entry: JournalEntry?

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.delegate = self
        countLabel.text = "Positive Streak: " + String(count)
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
    /*
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === addJournal else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let message = messageTextField.text ?? ""
        let date = dateLabel.text
        let count = Int(countLabel.text!)
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        entry = JournalEntry(message: message, date: date!, count: count!)
    }
    */
    
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
