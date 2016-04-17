//
//  MainWindowController.swift
//  Aspect
//
//  Created by Vest on 4/15/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {
    
    @IBOutlet weak var windowSizeLabel: NSTextField!
    
    var lastSize: NSSize!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        var adjustedSize = window!.frame
        adjustedSize.size = NSSize(width: adjustedSize.width, height: adjustedSize.width / 2)
        window!.setFrame(adjustedSize, display: true)
        
        lastSize = window!.frame.size
        
        print("Loaded: \(lastSize)")
    }
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    
    func windowWillResize(sender: NSWindow, toSize frameSize: NSSize) -> NSSize {
        print("frameSize \(frameSize)")
        
        var width : CGFloat = frameSize.width
        var height : CGFloat = frameSize.height
        
        if frameSize.height == lastSize.height {
            height = frameSize.width / 2
        } else if frameSize.width == lastSize.width {
            width = frameSize.height * 2
        } else {
            let deltaWidth = fabs(frameSize.width - lastSize.width)
            let deltaHeight = fabs(frameSize.height - lastSize.height)
            
            if deltaWidth > 5 * deltaHeight {
                width = frameSize.height * 2
            } else if deltaHeight > 5 * deltaWidth {
                height = frameSize.width / 2
            } else {
                if deltaWidth > deltaHeight {
                    width = frameSize.height * 2
                } else {
                    height = frameSize.width / 2
                }
            }
            print("Giant jump: width (\(deltaWidth)), height (\(deltaHeight))")
        }
        
        let newSize = NSSize(width: width, height: height)
        lastSize = newSize
        
        windowSizeLabel.stringValue = "Window Size: \(newSize)"
        
        return newSize
    }
}
