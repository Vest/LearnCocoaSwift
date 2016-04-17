//
//  AppDelegate.swift
//  SpeakLine
//
//  Created by Vest on 4/13/16.
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
}

