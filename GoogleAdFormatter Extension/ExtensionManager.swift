//
//  ExtensionManager.swift
//  GoogleAdFormatter Extension
//
//  Created by Mohssen Fathi on 1/22/20.
//  Copyright © 2020 Mohssen Fathi. All rights reserved.
//

import Foundation
import SafariServices

var state: ExtensionManager.State {
    return ExtensionManager.shared.state
}

class ExtensionManager {
    
    static let shared = ExtensionManager()
    
    init() {
        self.state = Defaults.get(key: "GoogleAdFormatterState") ?? State()
    }
    
    var page: SFSafariPage? {
        didSet { refresh() }
    }
    
    func setEnabled(_ enabled: Bool) {
        state.isEnabled = enabled
        refresh()
    }
    
    func setHideAdsEnabled(_ enabled: Bool) {
        state.isHideAdsEnabled = enabled
        refresh()
    }
    
    func setBackgroundColor(_ color: NSColor) {
        state.backgroundColor = State.Color(red: color.redComponent, green: color.greenComponent, blue: color.blueComponent, alpha: color.alphaComponent)
        refresh()
    }
    
    func refresh() {
        Defaults.save(state, key: "GoogleAdFormatterState")
        page?.dispatchMessageToScript(withName: "refresh", userInfo: domState)
        
        Notifications.post(.refresh)
    }
    
    class State: Codable {
        var isEnabled: Bool = true
        var numberOfAds: Int = 0
        var isHideAdsEnabled: Bool = false
        var backgroundColor: Color = Color(red: 255.0/255.0, green: 250.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        var backgroundColorString: String {
            let c = backgroundColor
            return "rgba(\(Int(c.red * 255.0)), \(Int(c.green * 255.0)), \(Int(c.blue * 255.0)), \(Int(c.alpha * 255.0)))"
        }
        
        struct Color: Codable {
            let red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat
            var nsColor: NSColor {
                return NSColor(deviceRed: red, green: green, blue: blue, alpha: alpha)
            }
        }
    }
    
    var domState: [String: Any] {
        return [
            "enabled": state.isEnabled,
            "display": (state.isEnabled && state.isHideAdsEnabled) ? "none" : "block",
            "backgroundColor": state.isEnabled ? state.backgroundColorString : "rgba(255,255,255,0)"
        ]
    }
    
    var state: State = State()
}

extension NSColor {
    var rgbString: String {
        return "rgb(\(Int(redComponent * 255.0)), \(Int(greenComponent * 255.0)), \(Int(blueComponent * 255.0)))"
    }
    var hexString: String {
        return String(format: "%02X%02X%02X", redComponent * 0xFF, greenComponent * 0xFF, blueComponent * 0xFF)
    }
}

extension Encodable {
    var dictionaryValue: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
  }
}
