//
//  PreferenceManager.swift
//  SpeakLine
//
//  Created by Vest on 6/12/16.
//  Copyright © 2016 Vest. All rights reserved.
//

import Cocoa

private let activeVoiceKey = "activeVoice"
private let activeTextKey = "activeText"

private let defaultVoice = NSSpeechSynthesizer.defaultVoice()
private let defaultText = "Able was I ere I saw Elba."

class PreferenceManager {
    private let userDefaults = NSUserDefaults.standardUserDefaults()

    init() {
        registerDefaultPreferences()
    }

    func registerDefaultPreferences() {
        let defaults = [ activeVoiceKey : defaultVoice,
                         activeTextKey  : defaultText ]
        userDefaults.registerDefaults(defaults)
    }

    var activeVoice: String? {
        get {
            return userDefaults.objectForKey(activeVoiceKey) as? String
        }
        set (newActiveVoice) {
            userDefaults.setObject(newActiveVoice, forKey: activeVoiceKey)
            print("Set default voice: \(newActiveVoice)")
        }
    }

    var activeText: String? {
        get {
            return userDefaults.objectForKey(activeTextKey) as? String
        }
        set (newActiveText) {
            userDefaults.setObject(newActiveText, forKey: activeTextKey)
            print("Set default voice: \(newActiveText)")
        }
    }

    func resetUserDefaults () {
        activeVoice = defaultVoice
        activeText = defaultText
    }
}