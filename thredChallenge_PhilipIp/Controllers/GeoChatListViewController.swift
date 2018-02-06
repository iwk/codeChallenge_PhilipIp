//
//  GeoChatListViewController.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 6/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import UIKit

class GeoChatListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let GeoChatCollectionViewCellClass = "GeoChatCollectionViewCell"
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GeoChatListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return geoChats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:GeoChatCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: GeoChatCollectionViewCellClass, for: indexPath) as! GeoChatCollectionViewCell
        if (cell == nil)
        {
            let nib:Array = Bundle.main.loadNibNamed(GeoChatCollectionViewCellClass
                , owner: self, options: nil)!
            cell = nib[0] as? GeoChatCollectionViewCell
            
            print("cell loaded")
        }
        
        cell.lblName.text = "ok"
        
        return cell
    }
}




