//
//  MainWindowController.swift
//  RandomPassword
//
//  Created by Vest on 4/5/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var textField: NSTextField!
    
    override var windowNibName: String? {
        // print("Default windowNibName was", super.windowNibName)
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func generatePassword(sender: AnyObject) {
        let length = 8
        let password = generateRandomString(length)
        
        textField.stringValue = password
    }
}
