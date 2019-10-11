//
//  WallTableViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 05/10/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class WallTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var fullNameFrom: UILabel!
    @IBOutlet weak var avatarFrom: UIImageView!
    @IBOutlet weak var dateFrom: UILabel!
    
    @IBOutlet weak var wallCollection: UICollectionView!
    
    var groups: [Group]?
    var profile: [Profile]?
    var wall: Item333? {
    
        didSet {

            let fromProfile = profile?.filter { $0.id == wall!.fromID }

            for item in fromProfile! {

                fullName.text = "\(item.firstName!) \(item.lastName!)"
            }
            

            if let wall = wall?.copyHistory {
                
                fullNameFrom.isHidden = false
                avatarFrom.isHidden = false
                dateFrom.isHidden = false
                var fromProfile: [Profile]?
                
                for item in wall {
                    
                     fromProfile = profile?.filter { $0.id  == item.fromID! * (-1)  }
                }
                if !fromProfile!.isEmpty {
                    
                    fullNameFrom.text = "\(fromProfile![0].firstName!) \(fromProfile![0].lastName!)"
                    
                } else  if fromProfile!.isEmpty{
                    
                    var fromGroup: [Group]?
                    
                    if let groups = groups {
                        
                        for item2 in wall {
                            
                            fromGroup = groups.filter { $0.id == item2.fromID! * (-1) }
                            
                            if !fromGroup!.isEmpty {
                             break
                            
                        }
                       
                    }
                        
                        
                        if !fromGroup!.isEmpty {
                            
                            fullNameFrom.text = "\(fromGroup![0].name!)"
                        }
                    }
                   
                }
                
                for item in fromProfile! {
                    
                    fullNameFrom.text = "\(item.firstName!) \(item.lastName!)"
                }

            } else {
                
                fullNameFrom.isHidden = true
                avatarFrom.isHidden = true
                dateFrom.isHidden = true

            }
            //print(wall!.copyHistory![0].fromID!*(-1))
            
                
        }
    }
    
    
}

