//
//  SecondElementTableViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 17/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import Kingfisher

class SecondElementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureMenu: UIImageView!
    @IBOutlet weak var nameMenu: UILabel!
    @IBOutlet weak var descriptionMenu: UILabel!
    @IBOutlet weak var isOnlinePicture: UIImageView!
    
    
    var discription: String? {
        
        didSet {
            
            descriptionMenu.text = discription
        }
    }
    
    var object: SecondElementProtocol? {
        
        didSet {
            
            var resultPhoto: String?
            
            guard let object = self.object else { return }
            
            switch object {
                
            case is MainProfile:
                
                guard let mainProfile = object as? MainProfile else {return}
                
                guard let firstName = mainProfile.firstName, let secondName = mainProfile.lastName else {return}
                
                nameMenu.text = "\(firstName) \(secondName)"
                
                if let imageName = mainProfile.photo100 {
                
                resultPhoto = imageName
                
                } else {
                    
                    pictureMenu.image = UIImage(named: "friends")

                }
                
                
                
            case is Follower:
                
                guard let follower = object as? Follower else {return}
                    
                    guard let firstName = follower.firstName, let secondName = follower.lastName else {return}
                        
                        self.nameMenu.text = "\(firstName) \(secondName)"
                        
                    
                if let imageName = follower.photo200 {
                        
                        resultPhoto = imageName
                } else {
                    
                    pictureMenu.image = UIImage(named: "friends")

                }
                        
                
            case is Friend:
                
                guard let friend = object as? Friend else {return}
                    
                guard let firstName = friend.firstName, let secondName = friend.lastName else {return}
                        
                        nameMenu.text = "\(firstName) \(secondName)"
                        
                    
                if let imageName = friend.photo200_Orig {
                        
                    resultPhoto = imageName
                    
                } else {
                    
                    pictureMenu.image = UIImage(named: "friends")

                }
                    
                    if friend.online == 1 && friend.onlineMobile == 1 {
                        
                        isOnlinePicture.image = UIImage(named: "phone")
                        isOnlinePicture.isHidden = false
                        
                    } else if friend.online == 1 && friend.onlineMobile == nil {
                        
                        isOnlinePicture.image = UIImage(named: "pc")
                        isOnlinePicture.isHidden = false
                        
                    }
                    
                
                
            case is RecommendFriend:
                
                if let recommendFriend = object as? RecommendFriend {
                    
                    guard let firstName = recommendFriend.firstName, let secondName = recommendFriend.lastName else {return}
                        
                        nameMenu.text = "\(firstName) \(secondName)"
                        
                    
                    guard let country = recommendFriend.country?.title else {return}
                    guard let recomFriends = recommendFriend.commonCount else {return}
                    
                    if recomFriends != 0 {
                        
                        descriptionMenu.isHidden = false
                        
                        self.descriptionMenu.text = "\(country)\nОбщих друзей: \(recomFriends)"
                        
                    } else {
                        descriptionMenu.isHidden = true
                    }
                    
                    if let imageName = recommendFriend.photo200_Orig {
                        
                        resultPhoto = imageName
                        
                    } else {
                        
                        pictureMenu.image = UIImage(named: "friends")

                    }
                        
                        
                        
                    if recommendFriend.online == 1 && recommendFriend.onlineMobile == 1 {
                        
                        isOnlinePicture.image = UIImage(named: "phone")
                        isOnlinePicture.isHidden = false
                        
                    } else if recommendFriend.online == 1 && recommendFriend.onlineMobile == nil {
                        
                        isOnlinePicture.image = UIImage(named: "pc")
                        isOnlinePicture.isHidden = false
                        
                    }
                    
                }
                
            case is Group:
                
                guard let group = object as? Group else {return}
                    
                guard let name = group.name else {return}
                        
                        nameMenu.text = name
                                            
                if let imageName = group.photo200 {
                    
                    resultPhoto = imageName

                } else {
                    
                    pictureMenu.image = UIImage(named: "friends")
                    
                }
                        
                        
            default:
                
                break
            }
            
            guard let result = resultPhoto else {return}
                                let cornerRadius = self.pictureMenu.layer.preferredFrameSize().height/2
            print(cornerRadius)
            
           
                NetworkManager.shared.loadImageWithCashing(namePhoto: result, photo: pictureMenu, activity: nil, cornerRadius: cornerRadius)
            
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pictureMenu.image = nil
        isOnlinePicture.image = nil
        
        
    }
}

