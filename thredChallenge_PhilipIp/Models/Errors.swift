//
//  Errors.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 6/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case dataEmpty //place holder
    case dataInvalid //place holder
    case responseInvalid //place holder
    case statusCode(Int) //place holder
}
