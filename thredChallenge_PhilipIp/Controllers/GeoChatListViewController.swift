//
//  GeoChatListViewController.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 6/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import UIKit
//import SDWebImage

class GeoChatListViewController: UIViewController {
    
    //UI
    @IBOutlet weak var collectionView: UICollectionView!
    
    //name for registering reusable cell
    let GeoChatCollectionViewCellClass = "GeoChatCollectionViewCell"
    
    //block double tap while playing animation
    var acceptInteraction = true
    
    //getter for shared variable
    var geoChats: [GeoChat] {
        get {
            return DataManager.sharedInstance.geoChats
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prepare collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: GeoChatCollectionViewCellClass, bundle: nil), forCellWithReuseIdentifier: GeoChatCollectionViewCellClass)
        
    }
    
    //re enable interaction after coming back from other controllers
    override func viewWillAppear(_ animated: Bool) {
        acceptInteraction = true
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reloadData() {
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
        
    }
    
    
    
}


//MARK:- group of functions for collection view
extension GeoChatListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //set section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    //set cell count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return geoChats.count
    }
    
    //set cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    
    //display cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:GeoChatCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: GeoChatCollectionViewCellClass, for: indexPath) as! GeoChatCollectionViewCell
        if (cell == nil)
        {
            let nib:Array = Bundle.main.loadNibNamed(GeoChatCollectionViewCellClass
                , owner: self, options: nil)!
            cell = nib[0] as? GeoChatCollectionViewCell
            
            print("cell loaded")
        }
        
        //populate text
        cell.lblName.text = geoChats[indexPath.row].name
        
        //populate image
        cell.imgThumb.sd_setImage(with: geoChats[indexPath.row].thumbnailUrl, placeholderImage: UIImage(named: "chat"), options: .scaleDownLargeImages) { (image, err, cache, url) in
            
            
        }
        
        cell.imgThumb.layer.cornerRadius = cell.imgThumb.bounds.width/2
        
        
        
        return cell
    }
    
    
    //item is selected, get geochat, use prepare segue to open details view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if acceptInteraction
        {
            acceptInteraction = false
            
            //get selected geoChat
            let geoChat = geoChats[indexPath.row]
            print(geoChat)
            
            let cell = collectionView.cellForItem(at: indexPath)
            
            //animation
            let animation: CATransition = CATransition()
            //animation.delegate = self
            animation.duration = 0.8
            animation.timingFunction = .none
            animation.type = "rippleEffect"
            cell?.layer.add(animation, forKey: nil)
            
            
            //delay for animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                
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
        }
        
    }
}




