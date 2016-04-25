//
//  MainWindowController.swift
//  Thermostat
//
//  Created by Vest on 4/22/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    private var privateTemperature = 68
    dynamic var temperature: Int {
        set {
            print("set temperature to \(newValue)")
            privateTemperature = newValue
        }
        get {
            print("get temperature")
            return privateTemperature
        }
    }
    
    dynamic var isOn = true
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func makeWarmer(sender: NSButton) {
        // let newTemperature = temperature + 1
        // setValue(newTemperature, forKey: "temperature")
    
        // willChangeValueForKey("temperature")
        temperature += 1
        // didChangeValueForKey("temperature")
    }
    
    @IBAction func makeCooler(sender: NSButton) {
        // let newTemperature = temperature - 1
        // setValue(newTemperature, forKey: "temperature")
  
        // willChangeValueForKey("temperature")
        temperature -= 1
        // didChangeValueForKey("temperature")
    }
    
    override func setNilValueForKey(key: String) {
        switch key {
        case "temperature":
            temperature = 68
        default:
            super.setNilValueForKey(key)
        }
    }
}
