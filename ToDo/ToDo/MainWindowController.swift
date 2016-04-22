//
//  MainWindowController.swift
//  ToDo
//
//  Created by Vest on 4/17/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    var items: [String] = []
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    @IBAction func addToDo(sender: AnyObject) {
        let todo = textField.stringValue
        
        if  !createNewItemWithName(todo) {
            textField.becomeFirstResponder()
            return
        }
        textField.stringValue = ""
        
        tableView.reloadData()
    }
    
    @IBAction func debugAction(sender: NSButton) {
        print("Generate ToDo's")
        
        let todos: [String] = ["Eat", "Sleep",
                               "Code", "Play SC2",
                               "Troll", "Sleep again"]
        
        for _ in 0..<5 {
            let todo = todos[Int(arc4random_uniform(UInt32(todos.count)))]
            createNewItemWithName(todo)
        }
        
        tableView.reloadData()
    }
    
    func createNewItemWithName(item: String) -> Bool {
        if item.isEmpty {
            print("ToDo item is empty")
            return false
        }
        
        items.append(item)
        
        return true
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return items[row]
    }
    
    @IBAction func onEnterInTextField(sender: NSTextField) {
        let newTodo = sender.stringValue
        
        print("Edit todo. New value \(newTodo)")
        
        if !newTodo.isEmpty {
            items[tableView.selectedRow] = newTodo
        } else {
            print("New ToDo item is empty. Refresh tableView")
            
            tableView.reloadData()
        }
    }
}
