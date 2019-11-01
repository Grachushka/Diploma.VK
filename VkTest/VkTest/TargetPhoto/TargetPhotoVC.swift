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
    
    var photoName: String?
    var pictures: [Item]?
    var idPhoto: Int?
    var timeValue: UIPinchGestureRecognizer?

    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    func setPhoto(namePhoto: String) {
        
        let url = URL(string: namePhoto)
        
        self.photo.kf.setImage(with: url)
        {
            result in
            switch result {
                
            case .success(_):
                
                self.activity.stopAnimating()
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    func unwrappingPhoto(item: Item) -> String {
        
        var resultPhoto: String?
        
        if let photo = item.photo2560 {
            
            resultPhoto = photo
            
        } else  if let photo = item.photo1280 {
                           
            resultPhoto = photo
            
        } else if let photo = item.photo807 {
            
            resultPhoto = photo
            
        } else if let photo = item.photo604 {
            
            resultPhoto = photo
            
        } else if let photo = item.photo130 {
            
            resultPhoto = photo
            
        } else if let photo = item.photo75 {
            
            resultPhoto = photo
        }
        
        if let resultPhoto = resultPhoto {
            
            return resultPhoto
            
        }
        return ""
    }
    

    func config() {
        
        if let photo = photoName {
            
        setPhoto(namePhoto: photo)
            
        } else if let photoID = idPhoto {
            
            if let pictures = pictures {
                
              let photoName = unwrappingPhoto(item: pictures[photoID])
                
                setPhoto(namePhoto: photoName)
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photo.isUserInteractionEnabled = true
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipedByPhoto(_:)))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipedByPhoto(_:)))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self , action: #selector(pinchGesture(_:)))
        photo.addGestureRecognizer(pinchGesture)
        
        config()
        
    }
    
    @objc func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        
   
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            if CGFloat(view.transform.a) > 3 {
                view.transform.a = 3 // this is x coordinate
                view.transform.d = 3 // this is x coordinate
                   }
                   if CGFloat(view.transform.d) < 1 {
                       view.transform.a = 1 // this is x coordinate
                       view.transform.d = 1 // this is x coordinate
                   }
                   sender.scale = 1
               }   
    }
    
    @objc func leftSwipedByPhoto(_ gesture: UISwipeGestureRecognizer) {
        
        guard let pictures = pictures else { return }
        guard var id = idPhoto else { return }
        id += 1
        guard id != pictures.count else{ return }

        let photoName = unwrappingPhoto(item: pictures[id])
                      self.activity.startAnimating()
            setPhoto(namePhoto: photoName)
        
        idPhoto! += 1
    }
    @objc func rightSwipedByPhoto(_ gesture: UISwipeGestureRecognizer) {
                
        guard let pictures = pictures else { return }
        guard var id = idPhoto else { return }
              id -= 1
        
        guard id >= 0 else{ return }
        self.activity.startAnimating()
        
              let photoName = unwrappingPhoto(item: pictures[id])
                          
                  setPhoto(namePhoto: photoName)
              
              idPhoto! -= 1
        
        
    }
}
