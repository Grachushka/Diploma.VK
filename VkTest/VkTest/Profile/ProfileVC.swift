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
    @IBOutlet weak var dataCollection: UICollectionView!
    
    var isMe = false
    
    private var object: MainProfile?
    private var profileMenu = DataBase.shared.getProfileMenu()

    var id: Int?
    
    var pictures: [Item] = []{
        
        didSet {
            
            collectionPhoto.reloadData()
        }
    }
    @IBAction func Info(_ sender: UIButton) {
        
        let next: InfoVC = self.storyboard?.instantiateViewController(withIdentifier: "info") as! InfoVC
        
        next.object = object
        self.navigationController?.pushViewController(next, animated: true)
    }
    private func configDataOnView() {
                
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

        if isMe == true && object?.friendStatus == 0 {
            
            buttonIsFriend.setTitle("Редактировать", for: .normal)
            
        } else if object?.friendStatus == 0 {
            
            buttonIsFriend.setTitle("Добавить в друзья", for: .normal)
            
        } else if object?.friendStatus == 3 {
            
            buttonIsFriend.setTitle("У вас в друзьях", for: .normal)
            
        } else if object?.friendStatus == 1 {
            
            buttonIsFriend.setTitle("Отписаться", for: .normal)
            
        } else if object?.friendStatus == 2 {
            
            buttonIsFriend.setTitle("Оставить в подписчиках", for: .normal)
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
    func config() {
        
             collectionPhoto.register(UINib.init(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoGalleryCollectionViewCell")
        
             dataCollection.register(UINib.init(nibName: "DescriptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DescriptionCollectionViewCell")
        
             buttonIsFriend.layer.cornerRadius = buttonIsFriend.layer.preferredFrameSize().height/2
             
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        config()
          
        NetworkManager.shared.getInfoAboutMyProfile(id: id!) { result in

            switch result {

            case .success(let profile):
                
                self.object = profile.response[0]
                self.configDataOnView()
                
                if let friends = profile.response[0].counters?["friends"] {
                    
                    self.profileMenu[0].name = "\(friends)"
                    
                }
                
                if let commonCount = self.object!.commonCount {
                    
                    self.profileMenu[1].name = "\(commonCount)"
                    
                }
                
                if let followers = profile.response[0].counters?["followers"] {
                    
                    self.profileMenu[2].name = "\(followers)"
                    
                }
                
                if let groups = profile.response[0].counters?["groups"] {
                    
                    self.profileMenu[3].name = "\(groups)"
                    
                }
                
                if let photos = profile.response[0].counters?["photos"] {
                    
                    self.profileMenu[4].name = "\(photos)"
                    
                }
                
                if let videos = profile.response[0].counters?["videos"] {
                    
                    self.profileMenu[5].name = "\(videos)"
                    
                }
                
                if let audios = profile.response[0].counters?["audios"] {
                    
                    self.profileMenu[6].name = "\(audios)"
                    
                }
                
                if let gifts = profile.response[0].counters?["gifts"] {
                    
                    self.profileMenu[7].name = "\(gifts)"
                    
                }
                self.profileMenu = self.profileMenu.filter {$0.name != nil &&  $0.name != "0"}
                self.dataCollection.reloadData()
                

            case .failure(let error):
                print(error)

            }
        }
        
       
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

   extension ProfileVC: UICollectionViewDelegate {
       
   }

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: collectionPhoto.frame.size.height, height: collectionPhoto.frame.size.height)
    }
}
   
extension ProfileVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionPhoto {
            
            return pictures.count
        }
            
        else if collectionView == dataCollection {
            
            
            return profileMenu.count
            
        }
    return 0
    
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionPhoto {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryCollectionViewCell", for: indexPath) as! PhotoGalleryCollectionViewCell
                  cell.targetPhoto = pictures[indexPath.row]
                  
                  if let photo = pictures[indexPath.row].photo604 {
                      let photoURL = URL(string: "\(photo)")
                  cell.loadPictureImage(url: photoURL!)
                  return cell
            }
        } else if collectionView == dataCollection {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCollectionViewCell", for: indexPath) as! DescriptionCollectionViewCell
            cell.counted = profileMenu[indexPath.row].name
            cell.dataCounted = profileMenu[indexPath.row].picture
            
            return cell
                  
                 
        }
       return UICollectionViewCell()
    }
}


