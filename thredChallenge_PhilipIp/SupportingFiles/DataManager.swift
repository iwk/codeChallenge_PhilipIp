//
//  DataManager.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 6/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import Foundation

//Singleton class encapsulating generic data requests

class DataManager: NSObject {
    
    static let sharedInstance: DataManager = DataManager()
    
    //prevent unintented init
    private override init() {}
    
    //MARK:- Data requests
    func loadJson(urlString:String, completionHandler: @escaping (Data?, Error?) -> Void)
    {
        //check url
        guard let url = URL(string: urlString) else {
            print("load json error: " + urlString)
            completionHandler(nil, NetworkError.invalidUrl)
            return
        }
        
        //init task with url
        let task =  URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            //handle generic url error
            if (error != nil)
            {
                //TODO: further logging analytics
                print("data task error:"+urlString)
            }
            
            //completion closure
            completionHandler(data, error)
            return
            
        }
        task.resume()
    }
    
    
    
}
