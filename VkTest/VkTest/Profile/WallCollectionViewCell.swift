//
//  WallCollectionViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 07/10/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class WallCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    var label2: String? {
        
        didSet {
            
            label.text = label2
        }
    }
}
