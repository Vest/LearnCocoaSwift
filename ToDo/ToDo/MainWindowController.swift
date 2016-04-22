//
//  MainWindowController.swift
//  ToDo
//
//  Created by Vest on 4/17/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSTableViewDataSource {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    var items: [String] = []
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    @IBAction func addToDo(sender: NSButton) {
        let todo = textField.stringValue
        
        if todo.isEmpty {
            textField.becomeFirstResponder()
            
            print("ToDo is empty")
            return
        }
        textField.stringValue = ""
        
        print("Add todo: \(todo)")
        
        createNewItemWithName(todo)
        
        tableView.reloadData()
    }
    
    func createNewItemWithName(item: String) {
       items.append(item)
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return items[row]
    }
}
