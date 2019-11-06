//
//  PhotoGalleryCollectionViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 27/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import Kingfisher
class PhotoGalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    private weak var pictureTask: URLSessionDataTask?
    
    var item: Item? {
        
        didSet {
            
            guard let item = item else { return }
            
            var targetPhoto: String?
            
            
            if let photo = item.photo2560 {
                
                targetPhoto = photo
                
            } else if let photo = item.photo1280 {
                
                targetPhoto = photo
                
            } else if let photo = item.photo807 {
                
                targetPhoto = photo
                
            } else if let photo = item.photo604 {
                
                targetPhoto = photo
                
            } else if let photo = item.photo130 {
                
                targetPhoto = photo
                
            } else if let photo = item.photo75 {
                
                targetPhoto = photo
            }
            
            guard let photo = targetPhoto else { return }
            
            NetworkManager.shared.loadImageWithCashing(namePhoto: photo, photo: self.photo, activity: nil)
           
            
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        photo.image = nil
        pictureTask = nil
    }
}
