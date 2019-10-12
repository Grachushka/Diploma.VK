//
//  WallTableViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 05/10/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import Kingfisher

class WallTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var fullNameFrom: UILabel!
    @IBOutlet weak var avatarFrom: UIImageView!
    @IBOutlet weak var dateFrom: UILabel!
    
    @IBOutlet weak var textForCell: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var wallCollection: UICollectionView! {
        
        didSet {
            
            self.wallCollection.delegate = self
            self.wallCollection.dataSource = self
        }
    }
    
    var groups: [Group]?
    var profile: [Profile]?
    var wall: Item333? {
    
        didSet {
  
            if let title = wall?.text {
                
                self.title.text = title
                self.title.isHidden = false
            }
            if let first = wall?.copyHistory?.first {
                
                textForCell.isHidden = false
                textForCell.text = first.text
                
                let was = Date(timeIntervalSince1970: TimeInterval(first.date!))
                
                let calendarWas = Calendar.current.dateComponents([.year, .month,.day, .timeZone, .hour, .minute, .second],from: was)
                
                let calendarNow = Calendar.current.dateComponents([.year, .month,.day, .timeZone, .hour, .minute, .second],from: Date())
                
                if calendarWas.year != calendarNow.year {
                                                  
                    dateFrom.text = "\(calendarWas.day!).\(calendarWas.month!).\(calendarWas.year!) г."
                } else {
                    dateFrom.text = "\(calendarWas.day!).\(calendarWas.month!) в \(calendarWas.hour!):\(calendarWas.minute!)"
                }
                          
                
            } else  {
                
                textForCell.isHidden = true
            }
            
            let was = Date(timeIntervalSince1970: TimeInterval((wall?.date)!))
                     
            let calendarWas = Calendar.current.dateComponents([.year, .month,.day, .timeZone, .hour, .minute, .second],from: was)
            let calendarNow = Calendar.current.dateComponents([.year, .month,.day, .timeZone, .hour, .minute, .second],from: Date())
            if calendarWas.year != calendarNow.year {
                
                date.text = "\(calendarWas.day!).\(calendarWas.month!).\(calendarWas.year!) г."
            } else {
            date.text = "\(calendarWas.day!).\(calendarWas.month!) в \(calendarWas.hour!):\(calendarWas.minute!)"
            }
            
            let fromProfile = profile?.filter { $0.id == wall!.fromID}

            for item in fromProfile! {

                fullName.text = "\(item.firstName!) \(item.lastName!)"
                
                if let imageName = item.photo100 {

                        let url = URL(string: imageName)
                        
                        avatar.kf.setImage(
                        with: url
                       )
                        {
                            result in
                            switch result {
                                
                            case .success(_):
                          
                             self.avatar.layer.cornerRadius = self.avatar.layer.preferredFrameSize().height/2
                        
                                
                            case .failure(let error):
                                
                                print(error)
                        }
                    }
                }
              
            }
            

            if let wall = wall?.copyHistory {
                
                fullNameFrom.isHidden = false
                avatarFrom.isHidden = false
                dateFrom.isHidden = false
                
                var fromProfile: [Profile]?
                
                for item in wall {
                    
                     fromProfile = profile?.filter { $0.id  == item.fromID!}
                }
                if !fromProfile!.isEmpty {
                    
                    fullNameFrom.text = "\(fromProfile![0].firstName!) \(fromProfile![0].lastName!)"
                    
                    if let imageName = fromProfile![0].photo100 {

                            let url = URL(string: imageName)
                            
                            avatarFrom.kf.setImage(
                            with: url
                           )
                            {
                                result in
                                switch result {
                                    
                                case .success(_):
                              
                                    self.avatarFrom.layer.cornerRadius = self.avatarFrom.layer.preferredFrameSize().height/2
                            
                                    
                                case .failure(let error):
                                    
                                    print(error)
                            }
                        }
                    }
                    
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
                            
                            if let imageName = fromGroup![0].photo100 {

                                    let url = URL(string: imageName)
                                    
                                    avatarFrom.kf.setImage(
                                    with: url
                                   )
                                    {
                                        result in
                                        switch result {
                                            
                                        case .success(_):
                                      
                                            self.avatarFrom.layer.cornerRadius = self.avatarFrom.layer.preferredFrameSize().height/2
                                    
                                            
                                        case .failure(let error):
                                            
                                            print(error)
                                    }
                                }
                            }
                        }
                    }
                   
                }

            } else {
                
                fullNameFrom.isHidden = true
                avatarFrom.isHidden = true
                dateFrom.isHidden = true

            }
                
        }
    }
}


extension WallTableViewCell: UICollectionViewDelegate {
    
}

extension WallTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let wall = wall?.copyHistory {
return 1
//            return wall[0].attachments!.count
            
        } else if let attachments = wall?.attachments {
            return 1
//            return attachments.count
        }

        return 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallCollectionViewCell", for: indexPath) as! WallCollectionViewCell
        
        if let wall = wall?.copyHistory {
            
            if let attachments = wall.first?.attachments {

                cell.copyHistoryAttachment = attachments.first
                
                
            }
                        
        } else if let attachments = wall?.attachments {
            
            cell.copyHistoryAttachment = attachments.first
           
        }
        
        return cell
        
    }
    
}

extension WallTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 200, height: 200)
    }
}
