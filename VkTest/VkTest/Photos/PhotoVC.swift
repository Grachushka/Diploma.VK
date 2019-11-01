//
//  PhotoVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 29.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    
    var id: Int?
    
    var pictures: [Item] = [] {
        
        didSet {
            
            collection.reloadData()
        }
    }
    
    func config() {
        
         collection.register(UINib.init(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoGalleryCollectionViewCell")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
                    layout.minimumInteritemSpacing = 1
                    layout.minimumLineSpacing = 1
        
        let width = collection.layer.preferredFrameSize().width - (layout.minimumLineSpacing + layout.minimumInteritemSpacing)
        
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
                collection.collectionViewLayout = layout
        
        NetworkManager.shared.getWallPhotos(id: id!) { result in

            switch result {

            case .success(let pictures):
                
                self.pictures = pictures.response.items

            case .failure(let error):
                print(error)

            }
        }
        
    }
}

extension PhotoVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let next: TargetPhotoVC = self.storyboard?.instantiateViewController(withIdentifier: "TargetPhotoVC") as! TargetPhotoVC
        
//        var resultPhoto: String?
//
//
//       if let photo = pictures[indexPath.row].photo2560 {
//
//           resultPhoto = photo
//
//       } else if let photo = pictures[indexPath.row].photo1280 {
//
//           resultPhoto = photo
//
//       } else if let photo = pictures[indexPath.row].photo807 {
//
//           resultPhoto = photo
//
//       } else if let photo = pictures[indexPath.row].photo604 {
//
//           resultPhoto = photo
//
//       } else if let photo = pictures[indexPath.row].photo130 {
//
//           resultPhoto = photo
//
//       } else if let photo = pictures[indexPath.row].photo75 {
//
//           resultPhoto = photo
//
//       }
        
       
       //next.photoName = resultPhoto
        next.pictures = pictures
        next.idPhoto = indexPath.row
       self.navigationController?.pushViewController(next, animated: true)

    }
}

extension PhotoVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryCollectionViewCell", for: indexPath) as! PhotoGalleryCollectionViewCell
           
        if let photo = pictures[indexPath.row].photo2560 {
            
            cell.targetPhoto = photo
        }
        if let photo = pictures[indexPath.row].photo1280 {
            
            cell.targetPhoto = photo
            
        } else if let photo = pictures[indexPath.row].photo807 {
            
            cell.targetPhoto = photo
            
        } else if let photo = pictures[indexPath.row].photo604 {
            
            cell.targetPhoto = photo
            
        } else if let photo = pictures[indexPath.row].photo130 {
            
            cell.targetPhoto = photo
            
        } else if let photo = pictures[indexPath.row].photo75 {
            
            cell.targetPhoto = photo
        }
        
            return cell
    }
}



