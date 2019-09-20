//
//  ElementMenuTableViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 17/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class ElementMenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pictureMenu: UIImageView!
    @IBOutlet weak var nameMenu: UILabel!
    
    
     var elementMenu: ElementMenu? {
        
        didSet {
            nameMenu.text = elementMenu?.name
            
            if let imageName = elementMenu?.picture {
                pictureMenu.image = UIImage(named: imageName)
                
            } else {
                
                pictureMenu.image = nil
            }
            
        }
    }

    
}
