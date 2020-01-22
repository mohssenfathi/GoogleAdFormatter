//
//  SafariExtensionHandler.swift
//  GoogleAdFormatter Extension
//
//  Created by Mohssen Fathi on 1/21/20.
//  Copyright © 2020 Mohssen Fathi. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        ExtensionManager.shared.page = page
        ExtensionManager.shared.state.numberOfAds = (userInfo?["numberOfAds"] as? Int) ?? 0
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        let vc = NSStoryboard(name: NSStoryboard.Name("GoogleAdFormatter"), bundle: nil).instantiateInitialController() as! GoogleAdFormatterViewController
        return vc
    }

}
