//
//  ViewController.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 5/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        DataManager.sharedInstance.loadJson(urlString: DataAPI.urlString) { (jsonData, err) in
            
            //handle json data
            if (jsonData != nil) {
                
                let decoded = try! JSONDecoder().decode([GeoChat].self, from: jsonData!)
                
                print("number of items in json:")
                print(decoded.count)
                print(decoded)
                
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

