//
//  AppDelegate.swift
//  Aspect
//
//  Created by Vest on 4/15/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: MainWindowController?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let mainWindowController = MainWindowController()
        
        mainWindowController.showWindow(self)
        
        self.mainWindowController = mainWindowController
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

