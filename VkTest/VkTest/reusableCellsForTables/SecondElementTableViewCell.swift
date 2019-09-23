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
    private weak var pictureTask: URLSessionDataTask?
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
                pictureMenu.image = UIImage(named: "\(imageName)")
                 pictureMenu.layer.cornerRadius = 50
                
        }
    }
}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pictureTask?.cancel()
        pictureMenu.image = nil
        isOnlinePicture.image = nil
       

        
    }
    
    func loadPictureImage(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.pictureMenu.image = UIImage(data: data)
            }
        }
        pictureTask = task
        task.resume()
    }

  
    
}
