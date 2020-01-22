//
//  GoogleAdFormatterViewController.swift
//  GoogleAdFormatter Extension
//
//  Created by Mohssen Fathi on 1/21/20.
//  Copyright © 2020 Mohssen Fathi. All rights reserved.
//

import Cocoa
import SafariServices

class GoogleAdFormatterViewController: SFSafariExtensionViewController {

    @IBOutlet weak var backgroundColorWell: NSColorWell!
    @IBOutlet weak var hideAdsButton: NSButton!
    @IBOutlet weak var enabledButton: NSButton!
    @IBOutlet weak var adCountLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enabledButton.state = ExtensionManager.shared.state.isEnabled ? .on : .off
        hideAdsButton.state = ExtensionManager.shared.state.isHideAdsEnabled ? .on : .off
        backgroundColorWell.color = ExtensionManager.shared.state.backgroundColor.nsColor
        
        Notifications.observe(type: .refresh) { [weak self] _ in
            self?.adCountLabel.isHidden = state.numberOfAds <= 0
            self?.adCountLabel.stringValue = "\(state.numberOfAds) \("ad".pluralize(state.numberOfAds)) found on this page."
        }
    }
    
    @IBAction func enabled(_ sender: NSButton) {
        ExtensionManager.shared.setEnabled(sender.state == .on)
    }
    
    @IBAction func hideAds(_ sender: NSButton) {
        ExtensionManager.shared.setHideAdsEnabled(sender.state == .on)
    }
    
    @IBAction func coloeChanged(_ sender: NSColorWell) {
        ExtensionManager.shared.setBackgroundColor(sender.color)
    }
}

extension String {
    func pluralize(_ count: Int) -> String {
        return self + (count == 1 ? "" : "s")
    }
}
