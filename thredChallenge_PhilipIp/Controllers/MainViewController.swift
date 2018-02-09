//
//  ViewController.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 5/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    private var geoChatListViewController: GeoChatListViewController?
    private var mapViewController: MapViewController?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    
    //load data when collection view is ready
    override func viewDidAppear(_ animated: Bool) {
        
        downloadAndProcessData()
        
    }
    
    //download and process data
    func downloadAndProcessData()
    {
        DataManager.sharedInstance.loadJson(urlString: DataAPI.urlString) { (jsonData, err) in
            
            //handle json data
            if (jsonData != nil) {
                
                //convert json into objects by Swift4 codable
                DataManager.sharedInstance.geoChats = try! JSONDecoder().decode([GeoChat].self, from: jsonData!)
                
                print("number of items in json:")
                print(DataManager.sharedInstance.geoChats.count)
                //print(DataManager.sharedInstance.geoChats)
                self.populateData()
                
            }
        }
    }
    
    
    //update views and children controllers, called when data is loaded
    func populateData()
    {
        DispatchQueue.main.async{
            self.activityIndicator.stopAnimating()
        }
        
        geoChatListViewController?.reloadData()
        mapViewController?.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

