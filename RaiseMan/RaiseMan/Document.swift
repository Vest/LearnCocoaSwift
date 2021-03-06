//
//  Document.swift
//  RaiseMan
//
//  Created by Vest on 4/26/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

private var KVOContext: Int = 0

class Document: NSDocument, NSWindowDelegate {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet var arrayController: NSArrayController!

    @IBAction func addEmployee(sender: AnyObject) {
        let windowController = windowControllers[0]
        let window = windowController.window!

        let endedEditing = window.makeFirstResponder(window)
        if !endedEditing {
            print("Unable to end editing.")
            return
        }

        let undo: NSUndoManager = undoManager!

        if undo.groupingLevel > 0 {
            undo.endUndoGrouping()
            undo.beginUndoGrouping()
        }

        let employee = arrayController.newObject() as! Employee
        arrayController.addObject(employee)

        arrayController.rearrangeObjects()

        let sortedEmployees = arrayController.arrangedObjects as! [Employee]

        let row = sortedEmployees.indexOf(employee)!

        print("starting edit of \(employee) in row \(row)")
        tableView.editColumn(0,
                             row: row,
                             withEvent: nil,
                             select: true)
    }

    @IBAction func removeEmployees(sender: NSButton) {
        let selectedPeople: [Employee] = arrayController.selectedObjects as! [Employee]
        let alert = NSAlert()
        alert.messageText = "Do you really want to remove these people?"

        if (selectedPeople.count == 1) {
            alert.informativeText = "Do you want to remove " + selectedPeople.first!.name!
        } else {
            alert.informativeText = "\(selectedPeople.count) people will be removed."
        }
        alert.addButtonWithTitle("Remove")
        alert.addButtonWithTitle("Keep, but no raise")
        alert.addButtonWithTitle("Cancel")
        let window = sender.window!
        alert.beginSheetModalForWindow(window) { (response) -> Void in
            switch response {
            case NSAlertFirstButtonReturn:
                self.arrayController.remove(nil)
            case NSAlertSecondButtonReturn:
                for employee in self.arrayController.selectedObjects as! [Employee] {
                    employee.raise = 0.0
                }
                self.arrayController.rearrangeObjects()
            default: break
            }
        }
    }

    var employees: [Employee] = [] {
        willSet {
            for employee in employees {
                stopObservingEmployee(employee)
            }
        }
        didSet {
            for employee in employees {
                startObservingEmployee(employee)
            }
        }
    }

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }

    override func dataOfType(typeName: String) throws -> NSData {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        tableView.window?.endEditingFor(nil)

        return NSKeyedArchiver.archivedDataWithRootObject(employees)
    }

    override func readFromData(data: NSData, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        print("About to read data of type \(typeName).")
        employees = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Employee]
    }

    func insertObject(employee: Employee, inEmployeesAtIndex index: Int) {
        print("adding \(employee) to the employees array")

        let undo: NSUndoManager = undoManager!
        undo.prepareWithInvocationTarget(self).removeObjectFromEmployeesAtIndex(employees.count)

        if !undo.undoing {
            undo.setActionName("Add Person")
        }

        employees.append(employee)
    }

    func removeObjectFromEmployeesAtIndex(index: Int) {
        let employee: Employee = employees[index]

        print("removing \(employee) from the employees array")

        let undo: NSUndoManager = undoManager!
        undo.prepareWithInvocationTarget(self).insertObject(employee, inEmployeesAtIndex: index)

        if !undo.undoing {
            undo.setActionName("Remove Person")
        }

        employees.removeAtIndex(index)
    }

    func startObservingEmployee(employee: Employee) {
        employee.addObserver(self, forKeyPath: "name", options: .Old, context: &KVOContext)
        employee.addObserver(self, forKeyPath: "raise", options: .Old, context: &KVOContext)
    }

    func stopObservingEmployee(employee: Employee) {
        employee.removeObserver(self, forKeyPath: "name", context: &KVOContext)
        employee.removeObserver(self, forKeyPath: "raise", context: &KVOContext)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context != &KVOContext {
            // If the context does not match, this message
            //   must be intended for our superclass.
            super.observeValueForKeyPath(keyPath,
                                         ofObject: object,
                                         change: change,
                                         context: context)
            return
        }

        var oldValue: AnyObject? = change![NSKeyValueChangeOldKey]
        if oldValue is NSNull {
            oldValue = nil
        }

        let undo: NSUndoManager = undoManager!
        print("oldValue=\(oldValue)")
        undo.prepareWithInvocationTarget(object!).setValue(oldValue, forKeyPath: keyPath!)
    }
    
    func windowWillClose(notification: NSNotification) {
        employees=[]
    }
}

