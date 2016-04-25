//
//  MainWindowController.swift
//  Thermostat
//
//  Created by Vest on 4/22/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    var temperature = 68
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func makeWarmer(sender: NSButton) {
        let newTemperature = temperature + 1
        setValue(newTemperature, forKey: "temperature")
    }
    
    @IBAction func makeCooler(sender: NSButton) {
        let newTemperature = temperature - 1
        setValue(newTemperature, forKey: "temperature")
    }
}
