//
//  Notifications.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 6/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    //custom notification event types, used when one event has to be listened by multiple listeners
    //use protocol for one to one event
    static let mapViewDidUpdate = Notification.Name("mapDidUpdate") //place holder
    static let geoChatListViewDidUpdate = Notification.Name("geoChatListDidUpdate") //place holder
    static let dataDidUpdate = Notification.Name("dataDidUpdate") //place holder
    
}
