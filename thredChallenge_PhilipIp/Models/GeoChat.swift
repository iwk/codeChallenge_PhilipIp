//
//  GeoChat.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 6/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import Foundation
import CoreLocation


struct GeoChat: Codable
{
    //String, URL, Bool and Date conform to Codable.
    let name: String?
    let radius:Double?
    let maxRadius:Double?
    let thumbnailUrl:URL?
    
    //CLLocationCoordinate2D not conform to Codable, refer to extension file for custom decoding
    let coord: [CLLocationCoordinate2D?]?
    
    
}


