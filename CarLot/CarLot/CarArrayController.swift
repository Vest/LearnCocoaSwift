//
//  CarArrayController.swift
//  CarLot
//
//  Created by Vest on 5/25/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var tableView: NSTableView!
    
    override func newObject() -> AnyObject {
        let newObj = super.newObject() as! NSObject
        let now = NSDate()
        
        newObj.setValue(now, forKey: "datePurchased")
        
        return newObj;
    }
    
    @IBAction func addCar(sender: AnyObject) {
        print("Add new car")
        
        let endedEditing = window.makeFirstResponder(window)
        if !endedEditing {
            print("Unable to end editing.")
            return
        }

        let undo: NSUndoManager = window.undoManager!
        
        if undo.groupingLevel > 0 {
            undo.endUndoGrouping()
            undo.beginUndoGrouping()
        }
        
        let car = newObject()
        addObject(car)
        
        let row = arrangedObjects.count - 1
        
        print("starting edit of \(car) in row \(row)")
        tableView.editColumn(0,
                             row: row,
                             withEvent: nil,
                             select: true)
    }
}