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
    
    var count: Int = 0
    var entry: JournalEntry?

    override func viewDidLoad() {
        super.viewDidLoad()
        count = UserDefaults.standard.integer(forKey: "Count")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addJournalSegue" {
            let nav = segue.destination as! UINavigationController
            let entryView = nav.topViewController as! EntryTableViewController
            
            let message = messageLabel.text
            let date = dateLabel.text
            let count = self.count
            
            entry = JournalEntry(message: message!, date: date!, count: count)
            
            entryView.newEntry = entry
            // print((entryView.newEntry?.message)! + (entryView.newEntry?.date)! + String(describing: entryView.newEntry?.count))

        }
        /*
        guard let button = sender as? UIButton, button === addJournal else {
            os_log("The add journal button was not pressed, canceling", log: OSLog.default, type: .debug)
            return
        }
        */
        

    }
    
    //MARK: Actions
    @IBAction func incrementCount(_ sender: UIButton) {
        count += 1
        countLabel.text = "Positive Streak: " + String(count)
        UserDefaults.standard.set(count, forKey: "Count")
        
        UIView.animate(withDuration: 0.2, animations: {
            self.addCount.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
        }, completion: { (finish) in
            UIView.animate(withDuration: 0.2, animations: {
                self.addCount.transform = CGAffineTransform.identity
            })
        })
    }

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
        
    
    /*
     private func saveJournal() {
     let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(journalEntries, toFile: JournalEntry.ArchiveURL.path)
     
     if isSuccessfulSave {
     os_log("Journal successfully saved.", log: OSLog.default, type: .debug)
     } else {
     os_log("Failed to save journals...", log: OSLog.default, type: .error)
     }
     }
     
     private func loadJournals() -> [JournalEntry]?  {
     return NSKeyedUnarchiver.unarchiveObject(withFile: JournalEntry.ArchiveURL.path) as? [JournalEntry]
     }

    */
}
