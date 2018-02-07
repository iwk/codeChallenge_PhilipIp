//
//  ViewController.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 5/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    private var geoChatListViewController: GeoChatListViewController?
    private var mapViewController: MapViewController?

    
    //var geoChats:[GeoChat] = []
    
    //access controllers from storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let collectionVC = destination as? GeoChatListViewController {
            geoChatListViewController = collectionVC
            //locationController.delegate = self
        }
        
        if let mapVC = destination as? MapViewController {
            mapViewController = mapVC
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DataManager.sharedInstance.loadJson(urlString: DataAPI.urlString) { (jsonData, err) in
            
            //handle json data
            if (jsonData != nil) {
                
                DataManager.sharedInstance.geoChats = try! JSONDecoder().decode([GeoChat].self, from: jsonData!)
                
                print("number of items in json:")
                print(DataManager.sharedInstance.geoChats.count)
                //print(DataManager.sharedInstance.geoChats)
                self.populateData()
                
            }
        }
    }
    
    func populateData()
    {
        geoChatListViewController?.reloadData()
        mapViewController?.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

