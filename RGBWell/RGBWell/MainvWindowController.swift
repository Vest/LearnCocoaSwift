//
//  MainvWindowController.swift
//  RGBWell
//
//  Created by Vest on 4/10/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var colorWell: NSColorWell!
  
    @IBOutlet weak var rSlider: NSSlider!
    @IBOutlet weak var gSlider: NSSlider!
    @IBOutlet weak var bSlider: NSSlider!
    
    var r = 0.0
    var g = 0.0
    var b = 0.0
    let a = 1.0
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        rSlider.doubleValue = r
        gSlider.doubleValue = g
        bSlider.doubleValue = b
        updateColor()
    }
    
    @IBAction func adjustRed(sender: NSSlider) {
        print("R slider's value is \(sender.floatValue)")
        r = sender.doubleValue
        updateColor()
    }

    @IBAction func adjustGreen(sender: NSSlider) {
        print("G slider's value is \(sender.floatValue)")
        g = sender.doubleValue
        updateColor()
    }
    
    @IBAction func adjustBlue(sender: NSSlider) {
        print("B slider's value is \(sender.floatValue)")
        b = sender.doubleValue
        updateColor()
    }
    
    func updateColor() {
        let newColor = NSColor(calibratedRed: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
        colorWell.color = newColor
    }
}

