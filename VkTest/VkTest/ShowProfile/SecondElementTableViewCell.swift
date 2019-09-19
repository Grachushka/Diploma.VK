//
//  SecondElementTableViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 17/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class SecondElementTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureMenu: UIImageView!
    @IBOutlet weak var nameMenu: UILabel!
    @IBOutlet weak var descriptionMenu: UILabel!
    
    var secondElementMenu: SecondElementMenu? {
        
        didSet {
            nameMenu.text = secondElementMenu?.name
            descriptionMenu.text = secondElementMenu?.discription
            
            if let imageName = secondElementMenu?.picture {
                pictureMenu.image = UIImage(named: imageName)
                
            } else {
                
                pictureMenu.image = nil
            }
            
        }
    }

  
    
}
