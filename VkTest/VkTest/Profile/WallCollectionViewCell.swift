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
            
            if let copyHistoryAttachment = copyHistoryAttachment {
                
                var resultImageName: String?
                
                if let type = copyHistoryAttachment.type {
                                        
                    switch type {
                        
                    case .video:
                        print("video")
                        
                        
                        
                        if let imageName = copyHistoryAttachment.video?.photo1280 {
                            resultImageName = imageName
                            
                        } else if let imageName = copyHistoryAttachment.video?.photo800 {
                            resultImageName = imageName
                            
                        } else if let imageName = copyHistoryAttachment.video?.photo320 {
                            resultImageName = imageName
                            
                        }
                        
                        
                        
                    case .doc:
                        
                        print("doc")
                        
                        if let copyHistoryAttachment = copyHistoryAttachment.doc {
                            if let preview = copyHistoryAttachment.preview {
                                if let sizes = preview.photo!.sizes {
                                    if let imageName = sizes[2].src {
                                        
                                        resultImageName = imageName
                                    }
                                }
                            } else {
                                return 
                            }
                            
                        } else if let imageName = copyHistoryAttachment.doc!.preview!.photo!.sizes![1].src {
                           resultImageName = imageName
                            
                        } else if let imageName = copyHistoryAttachment.doc!.preview!.photo!.sizes![0].src {
                            resultImageName = imageName
                            
                        }
                        
                        
                    case .link:
                        
                        print("link")
                        
                        if let imageName = copyHistoryAttachment.link!.photo?.photo604 {
                            resultImageName = imageName
                            
                        } else  if let imageName = copyHistoryAttachment.link!.photo?.photo130 {
                           resultImageName = imageName
                        }
                        
                        
                    case .photo:
                        print("photo")
                        
                        if let imageName = copyHistoryAttachment.photo!.photo2560 {
                           resultImageName = imageName
                            
                        } else if let imageName = copyHistoryAttachment.photo!.photo1280 {
                           resultImageName = imageName
                            
                        } else if let imageName = copyHistoryAttachment.photo!.photo807 {
                            resultImageName = imageName
                            
                        } else if let imageName = copyHistoryAttachment.photo!.photo604 {
                            resultImageName = imageName
                            
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
                        
                    }
                    
                    guard let resultImageName = resultImageName else {return}
                    NetworkManager.shared.loadImageWithCashing(namePhoto: resultImageName, photo: imageView, activity: nil)
                }
            }
        }
    }
}
