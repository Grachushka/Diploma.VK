//
//  PhotoGalleryCollectionViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 27/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

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
                        let task = URLSession.shared.dataTask(with: resultPhoto) { [weak self] data, _, _ in
                            guard let data = data else { return }
                            DispatchQueue.main.async { [weak self] in
                                self?.photo.image = UIImage(data: data)
                            }
                        }
                        pictureTask = task
                        task.resume()
            
            } else {
                self.photo.image = nil
                }
            
            
            
//                              if let resultPhoto = photoURL {
//
//                                self.photo.kf.setImage(
//                                   with: resultPhoto
//                                  )
                              }
        
        }
    }
    
    
//    func loadPictureImage(url: URL) {
//        

//    }
    override func prepareForReuse() {
        photo.image = nil
//        pictureTask = nil
    }
}
