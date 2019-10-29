//
//  TargetPhotoVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 25.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import Kingfisher

class TargetPhotoVC: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var photoName: String?
        
        if let photo = item?.photo2560 {
                        
            photoName = photo
           
        } else if let photo = item?.photo1280 {
                        
            photoName = photo
            
        } else if let photo = item?.photo807 {
                        
            photoName = photo
            
        } else if let photo = item?.photo604 {
            
            photoName = photo
            
        } else if let photo = item?.photo130 {
            
            photoName = photo
        }
        
        if let resultPhotoName = photoName {
            
            let url = URL(string: resultPhotoName)
            photo.kf.setImage(with: url )

        }        
    }
}
