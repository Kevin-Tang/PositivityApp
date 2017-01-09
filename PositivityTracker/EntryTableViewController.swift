//
//  EntryTableViewController.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/8/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit
import os.log

class EntryTableViewController: UITableViewController {
    
    //MARK: Properties
    var journalEntries = [JournalEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load any saved meals, otherwise load sample data.
        if let savedJournal = loadJournals() {
            journalEntries += savedJournal
        }
        else {
            // Load the sample data.
            loadExampleEntries()
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journalEntries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EntryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EntryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let entry = journalEntries[indexPath.row]

        cell.messageLabel.text = entry.message
        cell.dateLabel.text = entry.date
        cell.countLabel.text = "Positive Streak: " + String(entry.count)
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            journalEntries.remove(at: indexPath.row)
            saveJournal()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Navigation
    @IBAction func home(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        // text to share
        let text = "My latest Positive Moment I just tracked: " + journalEntries[journalEntries.count - 1].message
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = []
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    //MARK: Private Methods
    
    private func loadExampleEntries() {
        let entry1 = "Today was a wonderful day because I petted a strangeer's dog!"
        let entry2 = "It was a nice 70 degrees!"
        let entry3 = "Work was surprisingly therapeutic"
        
        let date1 = "November 24, 2016"
        let date2 = "December 25, 2016"
        let date3 = "January 1, 2017"
        
        guard let journal1 = JournalEntry(message: entry1, date: date1, count: 20) else {
            fatalError("Unable to instantiate journal1")
        }
        
        guard let journal2 = JournalEntry(message: entry2, date: date2, count: 25) else {
            fatalError("Unable to instantiate journal2")
        }
        
        guard let journal3 = JournalEntry(message: entry3, date: date3, count: 1) else {
            fatalError("Unable to instantiate journal3")
        }
        
        journalEntries += [journal1, journal2, journal3]
    }
    
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

}
