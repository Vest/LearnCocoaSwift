//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Vest on 4/13/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!

    let preferenceManager = PreferenceManager()

    let speechSynth = NSSpeechSynthesizer()
    let voices = NSSpeechSynthesizer.availableVoices()

    var isStarted: Bool = false {
        didSet {
            updateButtons()
        }
    }

    override var windowNibName: String? {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        updateButtons()
        speechSynth.delegate = self

        for voice in voices {
            print(voiceNameForIdentifier(voice))
        }

        let defaultVoice = preferenceManager.activeVoice!
        if let defaultRow = voices.indexOf(defaultVoice) {
            let indexes = NSIndexSet(index: defaultRow)
            tableView.selectRowIndexes(indexes, byExtendingSelection: false)
            tableView.scrollRowToVisible(defaultRow)
        }
        textField.stringValue = preferenceManager.activeText!
    }

    @IBAction func speakIt(sender: NSButton) {
        let string = textField.stringValue
        if string.isEmpty {
            print("string from \(textField) is empty")
        } else {
            print("Start speaking: \"\(string)\"")
            speechSynth.startSpeakingString(string)
            isStarted = true
        }
    }

    @IBAction func stopIt(sender: NSButton) {
        print("stop button cliecked")
        speechSynth.stopSpeaking()
    }

    @IBAction func resetDefaults(sender: NSButton) {
        print("reset user defaults")
        preferenceManager.resetUserDefaults()

        windowDidLoad()
    }

    func updateButtons() {
        if isStarted {
            speakButton.enabled = false
            stopButton.enabled = true
        } else {
            stopButton.enabled = false
            speakButton.enabled = true
        }
    }

    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        print("finishSpeaking=\(finishedSpeaking)")
    }

    func windowShouldClose(sender: AnyObject) -> Bool {
        return !isStarted
    }

    func voiceNameForIdentifier(identifier: String) -> String {
        let attributes = NSSpeechSynthesizer.attributesForVoice(identifier)
        return attributes[NSVoiceName] as! String
    }

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return voices.count
    }

    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let voice = voices[row]
        let voiceName = voiceNameForIdentifier(voice)

        return voiceName
    }

    func tableViewSelectionDidChange(notification: NSNotification) {
        let row = tableView.selectedRow

        if row == -1 {
            speechSynth.setVoice(nil)
            return
        }
        let voice = voices[row]
        speechSynth.setVoice(voice)
        preferenceManager.activeVoice = voice
    }

    // MARK: - NSTextFieldDelegate
    override func controlTextDidChange(notification: NSNotification) {
        preferenceManager.activeText = (notification.object as! NSTextField).stringValue
    }
}
