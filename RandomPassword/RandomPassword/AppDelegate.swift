//
//  AppDelegate.swift
//  RandomPassword
//
//  Created by Vest on 4/5/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // @IBOutlet weak var window: NSWdindow!
    
    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        // let mainWindowController = MainWindowController(windowNibName: "MainWindowController")
        let mainWindowController = MainWindowController()
        mainWindowController.showWindow(self)
        
        self.mainWindowController = mainWindowController
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
}

