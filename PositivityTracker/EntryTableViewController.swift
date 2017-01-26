//
//  EntryTableViewController.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/8/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit
import os

class EntryTableViewController: UITableViewController{
    
    //MARK: Properties
    var journalEntries = [JournalEntry]()
    var newEntry: JournalEntry?
    var lat: Double?
    var long: Double?
    let detailSegueIdentifier = "ShowDetailSegue"
    let mapSegueIdentifier = "ShowMapSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load any saved entries, otherwise load sample data.
        if let savedJournal = loadJournals() {
            journalEntries += savedJournal
        }
        else {
            // Load the sample data.
            loadExampleEntries()
        }
        
        if newEntry != nil {
            journalEntries.append(newEntry!)
            saveJournal()
        }

        tableView.delegate = self
        tableView.dataSource = self
        
        // Adjust each table cell to fit the length of the text
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    //MARK: Table View data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalEntries.count
    }

    
    // This function populates the table with custom class cell Journal Entry
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EntryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EntryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate journal for the data source layout.
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
    // This function allows users to swipe left to delete objects in the table
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
   
    //MARK: Navigation
    @IBAction func home(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // This function passes data along to the detailView and mapView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == detailSegueIdentifier) {
            let destination = segue.destination as? DetailViewController
            let cellIndex = tableView.indexPathForSelectedRow?.row
            destination?.messageLine = journalEntries[cellIndex!].message
            destination?.dateLine = journalEntries[cellIndex!].date
            destination?.countLine = journalEntries[cellIndex!].count
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
        if (segue.identifier == mapSegueIdentifier) {
            let destination = segue.destination as? MapViewController
            destination?.lat = lat
            destination?.long = long
            os_log("lat and long sent!", log: OSLog.default, type: .debug)
        }
    }
    
    //MARK: Private Methods
    
    //This function loads example entries if there isn't any entries saved on the device
    private func loadExampleEntries() {
        let entry1 = "Today was a wonderful day because I petted a stranger's dog!"
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
    
    // This function saves the array of journalEntries to device
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
    
    //MARK: Animations
    
    private func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index: Int = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 2.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
    
}
