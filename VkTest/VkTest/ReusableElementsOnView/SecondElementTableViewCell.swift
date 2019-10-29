//
//  SecondElementTableViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 17/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import Kingfisher

class SecondElementTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureMenu: UIImageView!
    @IBOutlet weak var nameMenu: UILabel!
    @IBOutlet weak var descriptionMenu: UILabel!
    @IBOutlet weak var isOnlinePicture: UIImageView!

    var name: String? {
        
        didSet {
            
            nameMenu.text = name
         
            }
        }
    var isOnlineFromMobile: Bool? {
        
        didSet {
            
            
            if isOnlineFromMobile == true {
                
                isOnlinePicture.image = UIImage(named: "phone")
                isOnlinePicture.isHidden = false
                
            } else if isOnlineFromMobile == false {
                
                isOnlinePicture.image = UIImage(named: "pc")
                isOnlinePicture.isHidden = false
                
            }
        }
    }
    
    var discription: String? {
        
        didSet {
            
            descriptionMenu.text = discription
        }
    }
    var imageName: String? {
        
        didSet {
            
            
            if let imageName = imageName {

                let url = URL(string: imageName)
                
                pictureMenu.kf.setImage(
                with: url
               )
                {
                    result in
                    switch result {
                        
                    case .success(_):
                  
                     self.pictureMenu.layer.cornerRadius = self.pictureMenu.layer.preferredFrameSize().height/2
                
                        
                    case .failure(let error):
                        
                        print(error)
                }
        }
            } else {
                
          pictureMenu.image = UIImage(named: "friends")

            }
    }
}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pictureMenu.image = nil
        isOnlinePicture.image = nil
        
       
    }
}
