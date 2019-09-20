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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pictureTask?.cancel()
        
        pictureMenu.image = nil
        
        
    }
    
    
    var secondElementMenu: SecondElementMenu? {
        
        didSet {
            nameMenu.text = secondElementMenu?.name
            descriptionMenu.text = secondElementMenu?.discription
            pictureMenu.layer.cornerRadius = 50
            if let imageName = secondElementMenu?.picture {
                pictureMenu.image = UIImage(named: "\(imageName)")
                
                
            } else {
                
                pictureMenu.image = nil
            }
            
        }
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
