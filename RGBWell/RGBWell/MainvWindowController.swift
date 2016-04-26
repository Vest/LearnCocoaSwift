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
    
    dynamic var r = 0.0
    dynamic var g = 0.0
    dynamic var b = 0.0
    let a = 1.0
    
    dynamic var color: NSColor {
        let newColor = NSColor(calibratedRed: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
        return newColor
    }
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    class func keyPathsForValuesAffectingColor() -> NSSet {
        return Set(["r", "g", "b"])
    }
}

