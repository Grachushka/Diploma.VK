//
//  WallCollectionViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 07/10/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class WallCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var copyHistoryAttachment: CopyHistoryAttachment? {
        
        didSet {
            
            if let type = copyHistoryAttachment?.type {
                
                var url: URL?
                
                switch type {
                    
                case .video:
                    print("video")
                    
                    if let imageName = copyHistoryAttachment!.video?.photo1280 {
                    url = URL(string: imageName)
                        
                    } else if let imageName = copyHistoryAttachment!.video?.photo800 {
                    url = URL(string: imageName)
                        
                    } else if let imageName = copyHistoryAttachment!.video?.photo320 {
                    url = URL(string: imageName)
                        
                    }
                    
                    loadImage(url: url!)
                case .doc:
                    print("doc")
                    
                    
                    if let imageName = copyHistoryAttachment!.doc!.preview!.photo!.sizes![2].src {
                     url = URL(string: imageName)
           
                      
                    } else if let imageName = copyHistoryAttachment!.doc!.preview!.photo!.sizes![1].src {
                     url = URL(string: imageName)

                    } else if let imageName = copyHistoryAttachment!.doc!.preview!.photo!.sizes![0].src {
                     url = URL(string: imageName)
                    
                    }
                    loadImage(url: url!)
                    
                case .link:
                    
                    print("link")
                    
                    if let imageName = copyHistoryAttachment!.link!.photo?.photo604 {
                         url = URL(string: imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                  
                    } else  if let imageName = copyHistoryAttachment!.link!.photo?.photo130 {
                         url = URL(string: imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                    }
                    
                    loadImage(url: url!)
                    
                case .photo:
                    print("photo")
                    
                    if let imageName = copyHistoryAttachment!.photo!.photo2560 {
                         url = URL(string: imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)

                    } else if let imageName = copyHistoryAttachment!.photo!.photo1280 {
                     url = URL(string: imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                    
                    } else if let imageName = copyHistoryAttachment!.photo!.photo807 {
                     url = URL(string: imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                    
                    } else if let imageName = copyHistoryAttachment!.photo!.photo604 {
                     url = URL(string: imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                    
                    }
                    
                    loadImage(url: url!)
                    
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
                
                }
            }
        }
    }
    
    
    func loadImage(url: URL) {

        imageView.kf.setImage(with: url)
            {
                result in
                switch result {

                case .success(_):
                    print("success")
                case .failure(let error):
                    print(error)

            }
        }
    }
    
    
}
