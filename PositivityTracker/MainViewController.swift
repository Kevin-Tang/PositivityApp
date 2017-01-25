//
//  MainViewController.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/6/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit
import os

class MainViewController: UIViewController, UITextFieldDelegate{
    
    //MARK: Properties
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var addJournal: UIButton!
    @IBOutlet weak var addCount: UIButton!
    @IBOutlet weak var resetCount: UIButton!
    
    var count: Int = 0
    var entry: JournalEntry?

    override func viewDidLoad() {
        super.viewDidLoad()
        count = UserDefaults.standard.integer(forKey: "Count") // This sets the count to a stored value on the device
        messageTextField.delegate = self
        countLabel.text = "Positive Streak: " + String(count)
        dateLabel.text = getDate()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Observers for keyboard showing and hiding
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        // Round Buttons
        addCount.layer.cornerRadius = addCount.frame.size.width/2
        addCount.layer.masksToBounds = true
        addJournal.layer.cornerRadius = 6
        resetCount.layer.cornerRadius = 6
        
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
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
        addCount.isEnabled = false
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
        addCount.isEnabled = true
    }
    
    //MARK: Navigations
    
    // This function passes information along to the next view in order to build a new object in the table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addJournalSegue" {
            let nav = segue.destination as! UINavigationController
            let entryView = nav.topViewController as! EntryTableViewController
            
            let message = messageLabel.text
            let date = dateLabel.text
            let count = self.count
            
            entry = JournalEntry(message: message!, date: date!, count: count)
            
            entryView.newEntry = entry
        }
    }
    
    //MARK: Actions
    @IBAction func incrementCount(_ sender: UIButton) {
        count += 1
        countLabel.text = "Positive Streak: " + String(count)
        UserDefaults.standard.set(count, forKey: "Count")
        
        // Animates the button when pressed
        UIView.animate(withDuration: 0.2, animations: {
            self.addCount.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
        }, completion: { (finish) in
            UIView.animate(withDuration: 0.2, animations: {
                self.addCount.transform = CGAffineTransform.identity
            })
        })
    }

    // Resets the count and stores the value on the device
    @IBAction func resetCount(_ sender: UIButton) {
        count = 0
        countLabel.text = "Positive Streak: " + String(count)
        UserDefaults.standard.set(count, forKey: "Count")
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
