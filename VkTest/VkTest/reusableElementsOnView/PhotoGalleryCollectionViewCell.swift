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
    
    var targetPhoto: Item? {
        
    didSet {
        
        if let photo = targetPhoto?.photo1280 {
            self.photo.image = UIImage(named: photo)
        } else {
            self.photo.image = nil
            }
        }
    }
    
    
    func loadPictureImage(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.photo.image = UIImage(data: data)
            }
        }
        pictureTask = task
        task.resume()
    }
}
