//
//  MapItems.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 7/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import Foundation

/// Point of Interest Item which implements the GMUClusterItem protocol.
class POIItem: NSObject, GMUClusterItem {
    
    //details stored in marker
    var position: CLLocationCoordinate2D
    var name: String!
    var thumbnailUrl: URL?
    
    init(position: CLLocationCoordinate2D, name: String, thumbnailUrl:URL) {
        self.position = position
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
}
