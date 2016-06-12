//
//  EmployeeArrayController.swift
//  RaiseManCore
//
//  Created by Vest on 6/12/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class EmployeeArrayController : NSArrayController {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var tableView: NSTableView!
    
    let name: String? = "New Employee"
    let raise: Float = 0.05
    
    override func newObject() -> AnyObject {
        let newObj = super.newObject() as! NSObject
        
        newObj.setValue(name, forKey: "name")
        newObj.setValue(raise, forKey: "raise")
        
        return newObj;
    }
    
    @IBAction func addEmployee(sender: AnyObject) {
        print("Add new employee")
        
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
        
        let employee = newObject()
        addObject(employee)
        
        let row = arrangedObjects.count - 1
        
        print("starting edit of \(employee) in row \(row)")
        tableView.editColumn(0,
                             row: row,
                             withEvent: nil,
                             select: true)
    }
}