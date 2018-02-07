//
//  MapViewController.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 5/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import UIKit
import GoogleMaps


//MARK:- initialize map
class MapViewController: UIViewController {
    
    //Storyboard
    @IBOutlet weak var mapView: GMSMapView!
    
    //getter for shared variable
    var geoChats: [GeoChat] {
        get {
            return DataManager.sharedInstance.geoChats
        }
    }
    
    //map
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var zoomLevel: Float = 10.0
    
    //cluster
    private var clusterManager: GMUClusterManager!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initMap()
        initMapItems()
    }
    
    func initMap()
    {
        let camera = GMSCameraPosition.camera(withLatitude: -33.855223,
                                              longitude: 151.205869, zoom: 12)
        mapView.camera = camera
        mapView.delegate = self
        mapView.layer.cornerRadius = 16
        
        
        mapView.settings.myLocationButton = true
        
    }
    
    func initMapItems()
    {
        //Cluster objects
        var iconGenerator : GMUDefaultClusterIconGenerator!
        iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        
        addCoords(isCluster: true)
        
        // Call cluster() after items have been added to perform the clustering and rendering on map.
        clusterManager.cluster()
        
        // Register self to listen to both GMUClusterManagerDelegate and GMSMapViewDelegate events.
        clusterManager.setDelegate(self, mapDelegate: self)
        
    }
    
    func addCoords(isCluster: Bool) {
        
        print("geoChats.count")
        print(geoChats.count)
        for geoChat in geoChats {
            if isCluster {
                //add "GMUClusterItem" to cluster manager
                let item = POIItem(position: geoChat.coord![0]!, name: geoChat.name!, thumbnailUrl: geoChat.thumbnailUrl!)
                clusterManager.add(item)
            } else {
                //add "GMSMarker" to map
                let marker = GMSMarker(position: geoChat.coord![0]!)
                marker.title = geoChat.name
                marker.map = mapView
            }
        }
        
    }
    
    func reloadData() {
        DispatchQueue.main.async{
            self.initMapItems()
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


//MARK:- handle markers and clusters
extension MapViewController: GMSMapViewDelegate, GMUClusterManagerDelegate, GMUClusterRendererDelegate {
    
    
    func viewForMarker(userData:Any)->UIView {
        
        if userData is POIItem {
            
            //ini markerView
            let nib:Array = Bundle.main.loadNibNamed("MarkerView"
                , owner: self, options: nil)!
            let markerView = nib[0] as? MarkerView
            markerView?.lblCount.isHidden = true
            
            //set image
            markerView?.imgThumb.sd_setImage(with: (userData as! POIItem).thumbnailUrl, placeholderImage: UIImage(named: "chat"), options: .scaleDownLargeImages)
            markerView?.imgThumb.clipsToBounds = true
            markerView?.imgThumb.layer.cornerRadius = 20
            
            return markerView!
            
            
            
        } else {
            //cluster
            let cluster = userData as! GMUStaticCluster
            
            //init markerView
            let nib:Array = Bundle.main.loadNibNamed("MarkerView"
                , owner: self, options: nil)!
            let markerView = nib[0] as? MarkerView
            
            
            //shadow for cluster
            markerView?.layer.masksToBounds = false
            markerView?.layer.shadowColor = UIColor.black.cgColor
            markerView?.layer.shadowOpacity = 0.2
            markerView?.layer.shadowOffset = CGSize(width: 15, height: 12)
            markerView?.imgThumb.layer.shadowRadius = 1
            markerView?.layer.shadowPath = UIBezierPath(rect: (markerView?.imgThumb.bounds)!).cgPath
            //markerView?.layer.shouldRasterize = true
            //markerView?.layer.rasterizationScale = 0.5
            
            //set first image in cluster
            markerView?.imgThumb.sd_setImage(with: (cluster.items.first as! POIItem).thumbnailUrl, placeholderImage: UIImage(named: "chat"), options: .scaleDownLargeImages)
            
            //set second image in cluster
            markerView?.imgThumb2.sd_setImage(with: (cluster.items[1] as! POIItem).thumbnailUrl, placeholderImage: UIImage(named: "chat"), options: .scaleDownLargeImages)
            
            //thumb corner radius
            markerView?.imgThumb.clipsToBounds = true
            markerView?.imgThumb.layer.cornerRadius = 20
            markerView?.imgThumb2.clipsToBounds = true
            markerView?.imgThumb2.layer.cornerRadius = 20
            
            //label corner radius
            markerView?.lblCount.text = String(cluster.items.count)
            markerView?.lblCount.clipsToBounds = true
            markerView?.lblCount.layer.cornerRadius = 13
            
            return markerView!
        }
        
        
    }
    
    //set marker before render
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        
        marker.iconView = viewForMarker(userData: marker.userData ?? "")
        
    }
    
    
    private func clusterManager(clusterManager: GMUClusterManager, didTapCluster cluster: GMUCluster) {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
                                                 zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
    }
    
    //Show the marker title while tapping
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if (marker.userData is POIItem)
        {
            let item = marker.userData as! POIItem
            
            if (mapView.selectedMarker != marker)
            {
                //select marker
                
                marker.title = item.name
                mapView.selectedMarker = marker
                
                //focus camera with offset
                var point = mapView.projection.point(for: marker.position)
                point.y = point.y - 70
                let cameraUpdate:GMSCameraUpdate = GMSCameraUpdate.setTarget(mapView.projection.coordinate(for: point))
                mapView.animate(with: cameraUpdate)
            } else
            {
                
                let geoChat = geoChats.filter { $0.name == item.name }
                print(geoChat)
                
                //init details view controller
                let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsView") as? DetailsViewController
                
                //push with transition
                let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionReveal
                transition.subtype = kCATransitionFromRight
                self.navigationController?.view.layer.add(transition, forKey: nil)
                //_ = self.navigationController?.popToRootViewController(animated: false)
                self.navigationController?.pushViewController(detailsViewController!, animated: false)
            }
            
        } else
        {
            
            //zoom to location when cluster marker is tapped
            let cameraUpdate = GMSCameraUpdate.setTarget(marker.position, zoom: 16)
            mapView.animate(with: cameraUpdate)
        }
        
        
        
        return true
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        /*
         //not in use
         let item = POIItem(position: coordinate, name: "NEW")
         clusterManager.add(item)
         clusterManager.cluster()*/
    }
}




//MARK:- Handle user location
extension MapViewController: CLLocationManagerDelegate {
    
    
    func initLocation() {
        mapView.isMyLocationEnabled = true
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        initLocation()
        return false
    }
    
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}



