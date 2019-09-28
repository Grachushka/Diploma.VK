//
//  ProfileVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 27/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var buttonIsFriend: UIButton!
    @IBOutlet weak var ageCountry: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var image: UIImageView!
    private weak var pictureTask: URLSessionDataTask?
    @IBOutlet weak var collectionPhoto: UICollectionView!
    
    var isMe = false
    
    var object: ProfileProtocolVC?
    
    var pictures: [Item] = []{
        
        didSet {
            
            collectionPhoto.reloadData()
        }
    }
    private func config() {
        
        collectionPhoto.register(UINib.init(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoGalleryCollectionViewCell")
        buttonIsFriend.layer.cornerRadius = buttonIsFriend.layer.preferredFrameSize().height/2
           if let photo = object?.photo200_Orig {
            
                   let photoURL = URL(string: "\(photo)")
            
               loadPictureImage(url: photoURL!)
           }
           fullName.text = "\(object!.firstName!) \(object!.lastName!)"
           
           if object?.online == 1 {
               
               status.text = "online"
               
           } else if object?.online == 0 {
            
            status.text = "заходил \(object!.lastSeen!.time!) минут назад"
           }
        
        ageCountry.text = object?.city?.title

        if isMe == true && object?.isFriend == 0 {
            
            buttonIsFriend.setTitle("Редактировать", for: .normal)
            
        } else if object?.isFriend == 0 {
            
            buttonIsFriend.setTitle("Добавить в друзья", for: .normal)
            
        } else if object?.isFriend == 1 || object?.isFriend == nil{
            
            buttonIsFriend.setTitle("У вас в друзьях", for: .normal)
        }
        
    }
    
    func loadPictureImage(url: URL) {
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image.image = UIImage(data: data)
                self!.image.layer.cornerRadius = self!.image.layer.preferredFrameSize().height/2

            }
        }
        pictureTask = task
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        config()
        
       
        NetworkManager.shared.getWallPhotos(id: object!.id) { result in

            switch result {

            case .success(let pictures):
                
                self.pictures = pictures.response.items

            case .failure(let error):
                print(error)

            }
        }
       
    }
}

   extension ProfileVC: UICollectionViewDelegate {
       
   }

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: collectionPhoto.frame.size.height, height: collectionPhoto.frame.size.height)
    }
}
   
extension ProfileVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryCollectionViewCell", for: indexPath) as! PhotoGalleryCollectionViewCell
        cell.targetPhoto = pictures[indexPath.row]
        
         
        if let photo = pictures[indexPath.row].photo604 {
            let photoURL = URL(string: "\(photo)")
        cell.loadPictureImage(url: photoURL!)
        return cell
        
        }
       return UICollectionViewCell()
    }
}


