//
//  Notifications.swift
//  GoogleAdFormatter Extension
//
//  Created by Mohssen Fathi on 1/22/20.
//  Copyright © 2020 Mohssen Fathi. All rights reserved.
//

import Foundation

struct Notifications {
    
    enum NotificationType: String {
        
        case refresh
        
        var name: Notification.Name {
            return NSNotification.Name(rawValue: rawValue)
        }
    }
    
    static func post(_ type: NotificationType, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: type.name, object: object, userInfo: userInfo)
    }
    
    static func observe(type: NotificationType, using block: @escaping ((Notification) -> ())) {
        observe(types: [type], using: block)
    }
    
    static func observe(types: [NotificationType], using block: @escaping ((Notification) -> ())) {
        types.forEach {
            NotificationCenter.default.addObserver(forName: $0.name, object: nil, queue: nil, using: block)
        }
    }
    
    static let shared = Notifications()
}

