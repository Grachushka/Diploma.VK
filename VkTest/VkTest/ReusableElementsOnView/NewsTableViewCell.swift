//
//  NewsTableViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 14.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var who: UILabel!
    @IBOutlet weak var discription: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    
    
    
    var descriptionPhoto: String? {
        
        didSet {
            
            discription.text = descriptionPhoto
        }
    }
    var groups: [GroupRealm]?
    var profile: [ProfileRealm]?
    var news: OneNewsRealm? 
    
    
    var copyHistoryAttachment: CopyHistoryAttachmentRealm? {
        
        didSet {
            var resultPhoto: String?
            if let news = news {
                
                if news.sourceID.value! > 0 {
                    
                    let fromProfile = profile?.filter { $0.id.value == news.sourceID.value!}
                    
                    for i in fromProfile! {
                        
                        who.text = "\(i.firstName!) \(i.lastName!)"
                    }
                    
                } else if news.sourceID.value! < 0 {
                    
                    let fromGroup = groups?.filter { $0.id.value! == news.sourceID.value! * -1 }
                    for i in fromGroup! {
                        
                        who.text = i.name
                    }
                }
                
            }
            
            if let type = copyHistoryAttachment?.type {
                
                let resultType = AttachmentTypeRealm(rawValue: type)
                
                switch resultType {
                    
                case .video:
                    print("video")
                    
                    if let imageName = copyHistoryAttachment!.video?.photo1280 {
                        
                        resultPhoto = imageName
                        
                    } else if let imageName = copyHistoryAttachment!.video?.photo800 {
                       resultPhoto = imageName
                        
                    } else if let imageName = copyHistoryAttachment!.video?.photo320 {
                        resultPhoto = imageName
                        
                    }
                    
                    
                case .doc:
                    
                    print("doc")
                    
                    
                    if let imageName = copyHistoryAttachment!.doc!.preview!.photo!.sizes[2].src {
                        resultPhoto = imageName
                        
                        
                    } else if let imageName = copyHistoryAttachment!.doc!.preview!.photo!.sizes[1].src {
                        resultPhoto = imageName
                        
                    } else if let imageName = copyHistoryAttachment!.doc!.preview!.photo!.sizes[0].src {
                       resultPhoto = imageName
                        
                    }
                    
                case .link:
                    
                    print("link")
                    
                    if let imageName = copyHistoryAttachment!.link!.photo?.photo604 {
                       resultPhoto = imageName
                        
                    } else  if let imageName = copyHistoryAttachment!.link!.photo?.photo130 {
                        resultPhoto = imageName
                    }
                    
                    
                case .photo:
                    print("photo")
                    
                    if let imageName = copyHistoryAttachment!.photo!.photo2560 {
                       resultPhoto = imageName
                        
                    } else if let imageName = copyHistoryAttachment!.photo!.photo1280 {
                       resultPhoto = imageName
                        
                    } else if let imageName = copyHistoryAttachment!.photo!.photo807 {
                        resultPhoto = imageName
                        
                    } else if let imageName = copyHistoryAttachment!.photo!.photo604 {
                        resultPhoto = imageName
                        
                    }
                    
                    
                case .graffiti:
                    print("graffity")
                case .note:
                    print("note")
                case .app:
                    print("app")
                case .poll:
                    print("poll")
                case .page:
                    print("page")
                case .album:
                    print("album")
                case .photos_list:
                    print("photos_list")
                case .market:
                    print("market")
                case .market_album:
                    print("market_album")
                case .sticker:
                    print("sticker")
                case .pretty_cards:
                    print("pretty_cards")
                case .event:
                    print("event")
                case .posted_photo:
                    print("posted_photo")
                case .audio:
                    print("audio")
                    
                case .none:
                    break
                }
                
                guard let resultPhoto = resultPhoto else {return}
                NetworkManager.shared.loadImageWithCashing(namePhoto: resultPhoto, photo: imageVIew, activity: nil)
            }
        }
    }
    
    
//    func loadImage(url: URL) {
//
//        imageVIew.kf.setImage(with: url)
//        {
//            result in
//            switch result {
//
//            case .success(_):
//                print("success")
//            case .failure(let error):
//                print(error)
//
//            }
//        }
//    }
}
