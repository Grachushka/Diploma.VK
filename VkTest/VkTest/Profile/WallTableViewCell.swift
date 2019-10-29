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
    
    override func prepareForReuse() {
            
            
        wallCollection.reloadData()
        textForCell.text = nil
        title.text = nil
       
       }
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
            
            wallCollection.reloadData()
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            
            layout.minimumInteritemSpacing = 1
            layout.minimumLineSpacing = 1
            var count: Int?
            
            if let attachments = wall?.attachments {
                
                count = attachments.count

                for i in attachments {
                    
                    
                    if i.audio != nil {
                        
                        count! -= 1
                    }
                }
                 
                
            } else if let copyHistory = wall?.copyHistory {
                
                if let attachments = copyHistory.first?.attachments {
                    
                    count = attachments.count
                    
                    for i in attachments {
                        
                        
                        if i.audio != nil {
                            
                            count! -= 1
                        }
                    }
                }
                
                
            }
            
           if let resultCount = count {
                var result = Double(resultCount)
            
            if result == 5 {
                
                result /= 1.8
                
            } else if result == 3 {
                
                result /= 1.5
                
            } else if result > 6 {
                
                result /= 2.5
                
            }  else if result >= 4 && result < 7 {
                
                result /= 2
                
            }
                    
            let width = wallCollection.layer.preferredFrameSize().width-layout.minimumLineSpacing
            
                layout.itemSize = CGSize(width: width / CGFloat(result), height: (width/CGFloat(result)-1))
                    wallCollection.collectionViewLayout = layout
            }
        
            
            
            
            
            if let title = wall?.text {
                
                self.title.text = title
            }
            if let first = wall?.copyHistory?.first {
                
                textForCell.text = first.text
                
                let was = Date(timeIntervalSince1970: TimeInterval(first.date!))
                
                let calendarWas = Calendar.current.dateComponents([.year, .month,.day, .timeZone, .hour, .minute, .second],from: was)
                
                let calendarNow = Calendar.current.dateComponents([.year, .month,.day, .timeZone, .hour, .minute, .second],from: Date())
                
                if calendarWas.year != calendarNow.year {
                                                  
                    dateFrom.text = "\(calendarWas.day!).\(calendarWas.month!).\(calendarWas.year!) г."
                } else {
                    dateFrom.text = "\(calendarWas.day!).\(calendarWas.month!) в \(calendarWas.hour!):\(calendarWas.minute!)"
                }
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
            
            if let attachments = wall[0].attachments {
                
                var count = attachments.count

                for i in attachments {
                    
                    
                    if i.audio != nil {
                        
                        count -= 1
                    }
                }
                
                return count
            }
                        
        } else if let attachments = wall?.attachments {
            
            var count = attachments.count

            for i in attachments {
                
                
                if i.audio != nil {
                    
                    count -= 1
                }
            }
            
           return count
        }

        return 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallCollectionViewCell", for: indexPath) as! WallCollectionViewCell
        
        if let wall = wall?.copyHistory {
            
            if let attachments = wall.first?.attachments {

                cell.copyHistoryAttachment = attachments[indexPath.row]
                
                return cell
            }
                        
        } else if let attachments = wall?.attachments {
            
            cell.copyHistoryAttachment = attachments[indexPath.row]
           return cell
        }
        
        return UICollectionViewCell()
        
    }
   
}
