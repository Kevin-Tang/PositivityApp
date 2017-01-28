//
//  JournalEntry.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/8/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit
import MapKit
import os.log

class JournalEntry: NSObject, NSCoding {
    
    //MARK: Properties
    
    var message: String
    var date: String
    var count: Int
    var lat: Double?
    var long: Double?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("journalEntries")  
    
    //MARK: Types
    
    struct PropertyKey{
        static let message = "message"
        static let date = "date"
        static let count = "count"
        static let lat = "lat"
        static let long = "long"
    }
    
    //MARK: Initialization
    
    init?(message: String, date: String, count: Int, lat: Double, long: Double) {
        
        // Initialization should fail if there is no message or date
        guard !message.isEmpty || !date.isEmpty else{
            return nil
        }
        
        // Initialize stored properties
        self.message = message
        self.date = date
        self.count = count
        self.lat = lat
        self.long = long
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(message, forKey: PropertyKey.message)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(count, forKey: PropertyKey.count)
        aCoder.encode(lat, forKey: PropertyKey.lat)
        aCoder.encode(long, forKey: PropertyKey.long)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The message is required. If we cannot decode a name string, the initializer should fail.
        guard let message = aDecoder.decodeObject(forKey: PropertyKey.message) as? String else {
            os_log("Unable to decode the name for a Journal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let date = aDecoder.decodeObject(forKey: PropertyKey.date)
        let count = aDecoder.decodeInteger(forKey: PropertyKey.count)
        let lat = aDecoder.decodeObject(forKey: PropertyKey.lat)
        let long = aDecoder.decodeObject(forKey: PropertyKey.long)
        
        
        // Must call designated initializer.
        self.init(message: message, date: date as! String, count: count, lat: lat as! Double, long: long as! Double)
    }
}
