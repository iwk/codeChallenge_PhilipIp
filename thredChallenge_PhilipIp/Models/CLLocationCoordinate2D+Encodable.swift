//
//  CLLocationCoordinate2D+Encodable.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 6/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Codable {
    
    //maping name of variables
    enum CodingKeys: String, CodingKey
    {
        case latitude
        case longitude
    }
    
    //convert from object to data
    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    //convert from data to object
    public init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
    
    
}
