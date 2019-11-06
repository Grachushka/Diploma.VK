//
//  InfoTableViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 04/10/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    
    var elementMenu: ElementMenu? {
        
        didSet {
            
            guard let elementMenu = elementMenu else { return }
            name.text = elementMenu.picture
            value.text = elementMenu.name
            
        }
    }
}
