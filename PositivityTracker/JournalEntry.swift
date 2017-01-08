//
//  JournalEntry.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/8/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit

class JournalEntry {
    //MARK: Properties
    
    var message: String
    var date: String
    
    //MARK: Initialization
    
    init?(message: String, date: String) {
        
        // Initialization should fail if there is no message
        guard !message.isEmpty || !date.isEmpty else{
            return nil
        }
        
        // Initialize stored properties
        self.message = message
        self.date = date
    }
}
