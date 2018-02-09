//
//  MarkerView.swift
//  thredChallenge_PhilipIp
//
//  Created by Philip Ip on 7/2/18.
//  Copyright © 2018 Philip. All rights reserved.
//

import UIKit

class MarkerView: UIView {
    
    //label showing number of markers represented in the cluster
    @IBOutlet weak var lblCount: UILabel!
    
    //thumbnail
    @IBOutlet weak var imgThumb: UIImageView!
    
    //thumbnail stacked under to represent multiple markers in cluster
    @IBOutlet weak var imgThumb2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
