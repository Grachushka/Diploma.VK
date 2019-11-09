//
//  ProfileVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 27/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileVC: UIViewController {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var tableWall: UITableView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var buttonIsFriend: UIButton!
    @IBOutlet weak var ageCountry: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var image: UIImageView!
    private weak var pictureTask: URLSessionDataTask?
    @IBOutlet weak var collectionPhoto: UICollectionView!
    @IBOutlet weak var dataCollection: UICollectionView!
    var isMe = false
    @IBOutlet weak var buttonInfo: UIButton!
    @IBOutlet weak var tableConstr: NSLayoutConstraint!
    
    @IBOutlet weak var collectionPhotoConstr: NSLayoutConstraint!
    
    @IBOutlet weak var deactivated: UILabel!
    @IBOutlet weak var buttonIsFriendConstr: NSLayoutConstraint!
    @IBOutlet weak var imageContr: NSLayoutConstraint!
    @IBOutlet weak var dataCollectionConstr: NSLayoutConstraint!
    private var imagePicker: UIImagePickerController?
    private var object: MainProfile?
    private var profileMenu = DataBase.shared.getProfileMenu()
    
    var id: Int?
    
    private enum Source {
        case camera
        case library
    }
    var pictures: [Item] = []{
        
        didSet {
            collectionPhoto.reloadData()
        }
    }
    
    var wallItems: [Item333] = [] {
        
        didSet {
            

            tableWall.reloadData()
        }
    }
    
    
    var colItems: Int?
    
    var wallProfiles: [Profile]? = []
    var wallGroups: [Group]? = []
    
    var wall: Wall? {
        
        didSet {
            
            wallItems = self.wall!.response.items
            
            if let profiles = self.wall!.response.profiles {
                
                wallProfiles = profiles
                
            }
            if let groups = self.wall!.response.groups {
                
                wallGroups = groups
                
            }
        }
        
    }
    
    @IBAction func Info(_ sender: UIButton) {
        
        let next: InfoVC = self.storyboard?.instantiateViewController(withIdentifier: "info") as! InfoVC
        
        next.object = object
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    private func setTextOnButton() {
        
        if isMe == true && object?.friendStatus == 0 {
            
            buttonIsFriend.setTitle("Редактировать", for: .normal)
            
        } else if object?.friendStatus == 0 {
            
            buttonIsFriend.setTitle("Добавить в друзья", for: .normal)
            
        } else if object?.friendStatus == 3 {
            
            buttonIsFriend.setTitle("У вас в друзьях", for: .normal)
            
        } else if object?.friendStatus == 1 {
            
            buttonIsFriend.setTitle("Отписаться", for: .normal)
            
        } else if object?.friendStatus == 2 {
            
            buttonIsFriend.setTitle("Подписан на вас", for: .normal)
        }
    }
    private func setStatusOfUser() {
        
        if object?.online == 1 {
            
            status.text = "online"
            
        } else if object?.online == 0 {
            
            let was = Date(timeIntervalSince1970: TimeInterval(object!.lastSeen!.time!))
            
            let calendarWas = Calendar.current.dateComponents([.year, .month,.day, .timeZone, .hour, .minute, .second],from: was)
            
            //            let currentCalendar = Calendar.current.dateComponents([.year, .month,.day, .timeZone, .hour, .minute, .second],from: Date())
            //
            status.text = "был в сети \(calendarWas.day!).\(calendarWas.month!) \(calendarWas.hour!):\(calendarWas.minute!)"
        }
    }
    private func configDataOnView() {
        
        
        if let photo = object?.photo200_Orig {
            
            let cornerRadius = image.layer.preferredFrameSize().height/2

            NetworkManager.shared.loadImageWithCashing(namePhoto: photo, photo: image, activity: nil, cornerRadius: cornerRadius)
        }
        
        fullName.text = "\(object!.firstName!) \(object!.lastName!)"
        ageCountry.text = object?.city?.title
        
        setStatusOfUser()
        setTextOnButton()
        hiddenElementOnView(isHidden: false)

        
    }
    private func configCollectionPhoto() {
        
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout2.minimumInteritemSpacing = 1
        layout2.minimumLineSpacing = 2
        layout2.itemSize =
            CGSize(width:collectionPhoto.frame.size.height, height: collectionPhoto.frame.size.height)
        
        layout2.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionPhoto.collectionViewLayout = layout2
    }
    
    private func config() {
        
        collectionPhoto.register(UINib.init(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoGalleryCollectionViewCell")
        
        dataCollection.register(UINib.init(nibName: "DescriptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DescriptionCollectionViewCell")
        
        buttonIsFriend.layer.cornerRadius = buttonIsFriend.layer.preferredFrameSize().height/2
        
        configCollectionPhoto()
        tableWall.tableFooterView = UIView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Открыть фотографию",
                                       style: .default) { (action: UIAlertAction!) -> Void in
                                        
                                        let next: TargetPhotoVC = self.storyboard?.instantiateViewController(withIdentifier: "TargetPhotoVC") as! TargetPhotoVC
                                        
                                        var resultPhoto: String?
                                        
                                        if let photo = self.object?.photoMaxOrig {
                                            
                                            resultPhoto = photo
                                            
                                        }
                                        else if let photo = self.object?.photo400_Orig {
                                            resultPhoto = photo
                                            
                                        } else if let photo = self.object?.photo200 {
                                            resultPhoto = photo
                                        } else if let photo = self.object?.photo100 {
                                            resultPhoto = photo
                                        } else if let photo = self.object?.photo50 {
                                            resultPhoto = photo
                                        }
                                        guard let photo = resultPhoto else {return}
                                        next.photoName = photo
                                        
                                        self.navigationController?.pushViewController(next, animated: true)
                                        
        }
        let saveAction2 = UIAlertAction(title: "Изменить фотографию",
                                        style: .default) { (action: UIAlertAction!) -> Void in
                                            self.showChoose { [weak self] source in
                      guard let source = source else { return }
                      
                      let picker = UIImagePickerController()
                   picker.delegate = self!
                      
                      switch source {
                      case .camera:
                          picker.sourceType = .camera
                          picker.cameraCaptureMode = .photo
                      case .library:
                          picker.sourceType = .photoLibrary
                          picker.allowsEditing = true
                      }
                      
                      self?.present(picker, animated: true)
                      self?.imagePicker = picker
                    print(picker)
                      
                  }
        }
        
        let saveAction3 = UIAlertAction(title: "Удалить фотографию",
                                        style: .destructive) { (action: UIAlertAction!) -> Void in
                                            
                                            
        }
        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .cancel) { (action: UIAlertAction!) -> Void in
        }
        
        
        alert.addAction(saveAction)
        alert.addAction(saveAction2)
        alert.addAction(saveAction3)
        alert.addAction(cancelAction)
        
        self.present(alert,
                     animated: true,
                     completion: nil)
        
        
    }
    
    private func hiddenElementOnView(isHidden: Bool) {
        
        if isHidden {
            
            activity.startAnimating()
            
        } else if !isHidden {
            
            activity.stopAnimating()
        }
        dataCollection.isHidden = isHidden
        buttonInfo.isHidden = isHidden
        buttonIsFriend.isHidden = isHidden
        ageCountry.isHidden = isHidden
        status.isHidden = isHidden
        fullName.isHidden = isHidden
        image.isHidden = isHidden
        collectionPhoto.isHidden = isHidden
        tableWall.isHidden = isHidden
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hiddenElementOnView(isHidden: true)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
        
        config()
        
        NetworkManager.shared.getInfoAboutMyProfile(id: "\(id!)") { result in
            
            switch result {
                
            case .success(let profile):
                
                if let _ = profile.response[0].deactivated {
                    
                    self.activity.stopAnimating()
                    
                    self.deactivated.isHidden = false
                    self.tableWall.isHidden = true
                    self.collectionPhoto.isHidden = true
                    self.dataCollection.isHidden = true
                    self.buttonInfo.isHidden = true
                    
                    return
                }
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
        
        NetworkManager.shared.getWall(id: id!) { result in
            
            switch result {
                
            case .success(let wall):
                
                self.wall = wall
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    @IBAction func addToFriends(_ sender: Any) {
        
        if object?.friendStatus == 2 {
            
            let alert = UIAlertController(title: nil,
                                          message: nil,
                                          preferredStyle: .actionSheet)
            
            let saveAction = UIAlertAction(title: "Добавить в друзья",
                                           style: .destructive) { (action: UIAlertAction!) -> Void in
                                            self.addFriend()
            }
            
            let cancelAction = UIAlertAction(title: "Отмена",
                                             style: .cancel) { (action: UIAlertAction!) -> Void in
            }
            
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            self.present(alert,
                         animated: true,
                         completion: nil)
            
        } else if object?.friendStatus == 3 {
            
            let alert = UIAlertController(title: nil,
                                          message: nil,
                                          preferredStyle: .actionSheet)
            
            let saveAction = UIAlertAction(title: "Убрать из друзей",
                                           style: .destructive) { (action: UIAlertAction!) -> Void in
                                            NetworkManager.shared.deleteFriend(id: self.id!)
                                            self.buttonIsFriend.setTitle("Подписан на вас", for: .normal)
                                            self.object?.friendStatus = 2
                                            
            }
            
            let cancelAction = UIAlertAction(title: "Отмена",
                                             style: .cancel) { (action: UIAlertAction!) -> Void in
            }
            
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            self.present(alert,
                         animated: true,
                         completion: nil)
            
        } else if object?.friendStatus == 1 {
            
            NetworkManager.shared.deleteFriend(id: id!)
            self.buttonIsFriend.setTitle("Добавить в друзья", for: .normal)
            object?.friendStatus = 0
            
        } else if object?.friendStatus == 0 && !isMe {
            
            addFriend()
            
        }
    }
    private func addFriend() {
        
        NetworkManager.shared.addToFriend(id: id!, captcha_sid: "", captcha_key: "") { result in
            
            switch result {
                
            case .success(let status):
                
                if let captcha = status.error {
                    
                    
                    let alert = UIAlertController(title: "Капча",
                                                  message: "Введите капчу с картинки",
                                                  preferredStyle: .alert)
                    
                    let saveAction = UIAlertAction(title: "Ok",
                                                   style: .default) { (action: UIAlertAction!) -> Void in
                                                    
                                                    let textFieldCaptcha = alert.textFields![0] as UITextField
                                                    if let text = textFieldCaptcha.text {
                                                        
                                                        NetworkManager.shared.addToFriend(id: self.id!, captcha_sid: captcha.captchaSid!, captcha_key: text, result: {
                                                            result in
                                                            switch result {
                                                                
                                                            case .success(let data):
                                                                
                                                                if let status = data.response {
                                                                    
                                                                    if status == 1 {
                                                                        
                                                                        self.buttonIsFriend.setTitle("Отписаться", for: .normal)
                                                                        self.object?.friendStatus = 1
                                                                    } else if status == 2 {
                                                                        self.buttonIsFriend.setTitle("У вас в друзьях", for: .normal)
                                                                        self.object?.friendStatus = 3                                                }
                                                                }
                                                            case .failure(let data):
                                                                print(data)
                                                                
                                                            }
                                                        })
                                                    }
                    }
                    
                    let cancelAction = UIAlertAction(title: "Cancel",
                                                     style: .default) { (action: UIAlertAction!) -> Void in
                    }
                    
                    alert.addTextField {
                        (textField1: UITextField!) -> Void in
                        textField1.placeholder = "Captcha"
                    }
                    
                    alert.addAction(saveAction)
                    alert.addAction(cancelAction)
                    
                    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 80))
                    NetworkManager.shared.loadImageWithCashing(namePhoto: (status.error?.captchaImg)!, photo: imageView, activity: nil)
                    alert.view.addSubview(imageView)
                    
                    self.present(alert,
                                 animated: true,
                                 completion: nil)
                } else {
                    
                    if let status = status.response {
                        if status == 1 {
                            
                            self.buttonIsFriend.setTitle("Отписаться", for: .normal)
                            self.object?.friendStatus = 1
                            
                        } else if status == 2 {
                            self.buttonIsFriend.setTitle("У вас в друзьях", for: .normal)
                            self.object?.friendStatus = 3
                        }
                    }
                    
                }
                
                
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 500
    }
}

extension ProfileVC: UITableViewDelegate {
    
}

extension ProfileVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wallItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? WallTableViewCell {
            cell.groups = wallGroups
            cell.profile = wallProfiles
            cell.wall = wallItems[indexPath.row]
            
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension ProfileVC: UICollectionViewDelegate {
    
    
    
}

extension ProfileVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionPhoto {
            
            let next: TargetPhotoVC = self.storyboard?.instantiateViewController(withIdentifier: "TargetPhotoVC") as! TargetPhotoVC
            
            next.idPhoto = indexPath.row
            next.pictures = pictures
            
            self.navigationController?.pushViewController(next, animated: true)
            
        } else if collectionView == dataCollection {
            
            if profileMenu[indexPath.row].picture == "друзей" {
                
                let next: ShowFriendsVC = self.storyboard?.instantiateViewController(withIdentifier: "friends") as! ShowFriendsVC
                next.id = id!
                self.navigationController?.pushViewController(next, animated: true)
                
            } else if profileMenu[indexPath.row].picture == "общих" {
                
                let next: OurFriendsVC = self.storyboard?.instantiateViewController(withIdentifier: "OurFriendsVC") as! OurFriendsVC
                next.id = id!
                self.navigationController?.pushViewController(next, animated: true)
                
            } else if profileMenu[indexPath.row].picture == "подписчиков" {
                
                let next: FollowersVC = self.storyboard?.instantiateViewController(withIdentifier: "FollowersVC") as! FollowersVC
                next.id = "\(id!)"
                self.navigationController?.pushViewController(next, animated: true)
                
            } else if profileMenu[indexPath.row].picture == "групп" {
                
                let next: GroupsVC = self.storyboard?.instantiateViewController(withIdentifier: "GroupsVC") as! GroupsVC
                next.id = "\(id!)"
                self.navigationController?.pushViewController(next, animated: true)
            } else if profileMenu[indexPath.row].picture == "фото" {
                
                let next: PhotoVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoVC") as! PhotoVC
                next.id = id!
                self.navigationController?.pushViewController(next, animated: true)
            }
        }
    }
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
            
            cell.item = pictures[indexPath.row]
            
            return cell
            
            
        } else if collectionView == dataCollection {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCollectionViewCell", for: indexPath) as! DescriptionCollectionViewCell
            
            cell.elementMenu = profileMenu[indexPath.row]
            
            
            return cell
            
        }
        
        return UICollectionViewCell()
    }
    
    private func showChoose(choosen: @escaping (Source?) -> Void) {

        let alert = UIAlertController(title: "Choose source", message: nil, preferredStyle: .actionSheet)
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                    choosen(.camera)
                })
            }
            alert.addAction(UIAlertAction(title: "Library", style: .default) { _ in
                choosen(.library)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                choosen(nil)
            })
            
            present(alert, animated: true)
        }
    }
    


extension ProfileVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(scrollView.scrollIndicatorInsets)
        let contentOffset = scrollView.contentOffset.y
        
        if contentOffset > 2 {
            
            status.isHidden = true
            ageCountry.isHidden = true
            fullName.isHidden = true
            image.isHidden = true
            buttonInfo.isHidden = true
            
        } else if contentOffset < 1.9 {
            
            status.isHidden = false
            ageCountry.isHidden = false
            fullName.isHidden = false
            image.isHidden = false
            buttonInfo.isHidden = false
        }
        guard contentOffset < 85 else {return }
        print(contentOffset)
        imageContr.constant = (contentOffset * (-1)) * 2
        buttonIsFriendConstr.constant = (contentOffset * (-1)) * 5
        
    }
    
    
}

extension ProfileVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let cropped = info[.editedImage] as! UIImage
        
        NetworkManager.shared.getUploadMainPhotoServer(id: "\(id!)") { result in
            
            switch result {
                
            case .success(let resultUrl):
                
                print(resultUrl.response.uploadURL)
                NetworkManager.shared.UploadMainPhotoToServer(image: cropped, url: resultUrl.response.uploadURL)

            case .failure(let error):
                print(error)
                
            }
        }
        
    picker.dismiss(animated: true)
    
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           print("Cancel")
           picker.dismiss(animated: true)
       }
}
