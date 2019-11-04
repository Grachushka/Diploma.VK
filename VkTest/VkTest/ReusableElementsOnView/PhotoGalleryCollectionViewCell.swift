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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var targetPhoto: String? {
        
        didSet {
            
            if let photo = targetPhoto {
                let photoURL = URL(string: "\(photo)")
                
                if let resultPhoto = photoURL {
                    
                    self.photo.kf.setImage(
                        with: resultPhoto
                    )
                }
                
            }
        }
    }
    
    override func prepareForReuse() {
        photo.image = nil
        pictureTask = nil
    }
}
