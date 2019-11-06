//
//  DescriptionCollectionViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 30/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var dataCount: UILabel!
    
    var elementMenu: ElementMenu? {
        
        didSet {
            
            guard let elementMenu = elementMenu else {return}
            count.text = elementMenu.name
            dataCount.text = elementMenu.picture
            
        }
    }
}
