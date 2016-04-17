//
//  MainMenuController.swift
//  BusyApp
//
//  Created by Vest on 4/13/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class MainMenuController: NSWindowController {
    
    @IBOutlet weak var slider: NSSlider!
    @IBOutlet weak var showTicks: NSButton!
    @IBOutlet weak var hideTicks: NSButton!
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var check: NSButton!
    @IBOutlet weak var secure: NSSecureTextField!
    @IBOutlet weak var nonSecure: NSTextField!
    
    var lastPosition = 0
    
    override var windowNibName: String? {
        return "MainMenu"
    }
    
    @IBAction func ticksAction(sender: NSButton) {
        slider.numberOfTickMarks = sender.tag
    }
    
    @IBAction func sliderAction(sender: NSSlider) {
        let currentPosition = sender.integerValue
        
        if currentPosition > lastPosition {
            label.stringValue = "Slider goes up!"
        }
        else if currentPosition < lastPosition {
            label.stringValue = "Slider goes down!"
        }
        
        lastPosition = currentPosition
    }
    
    @IBAction func resetControlsAction(sender: NSButton) {
        slider.numberOfTickMarks = 0
        slider.doubleValue = (slider.minValue + slider.maxValue) / 2.0
        hideTicks.performClick(hideTicks)
        
        check.state = NSOffState
        checkAction(check)
        
        secure.stringValue = ""
        nonSecure.stringValue = ""
        label.stringValue = "Use the slider!"
    }

    
    @IBAction func checkAction(sender: NSButton) {
        sender.title = (sender.state == NSOnState ? "Uncheck me" : "Check me")
    }
    
    @IBAction func revealPasswordAction(sender: NSButton) {
        nonSecure.stringValue = secure.stringValue
    }
}