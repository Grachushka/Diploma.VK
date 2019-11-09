//
//  OurFriendsVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 25.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import Kingfisher

class OurFriendsVC: UIViewController {
    
    var id: Int?
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    
    var ourFriends:[MainProfile] = [] {
        
        didSet {
            
            table.reloadData()
            activity.stopAnimating()
            table.isHidden = false
            
        }
    }
    func config() {
        
        table.register(UINib(nibName: "SecondElementTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondElementMenu")
        table.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        table.isHidden = true
        
        NetworkManager.shared.getOurFriends(id: id!) { result in
            
            switch result {
                
            case .success(let ourFriends):
                
                if let countOurFriends = ourFriends.response {
                    
                    
                    let stringArray = countOurFriends.map { String($0) }
                    let resultArray = stringArray.joined(separator: ",")
                    
                    
                    NetworkManager.shared.getInfoAboutMyProfile(id: resultArray) { result in
                        
                        switch result {
                            
                        case .success(let profile):
                            
                            self.ourFriends = profile.response
                            
                        case .failure(let error):
                            print(error)
                            
                        }
                    }
                }
                
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        table.isHidden = true
        
        NetworkManager.shared.getOurFriends(id: id!) { result in
            
            switch result {
                
            case .success(let ourFriends):
                
                if let countOurFriends = ourFriends.response {
                    
                    
                    let stringArray = countOurFriends.map { String($0) }
                    let resultArray = stringArray.joined(separator: ",")
                    
                    NetworkManager.shared.getInfoAboutMyProfile(id: resultArray) { result in
                        
                        switch result {
                            
                        case .success(let profile):
                            
                            self.ourFriends = profile.response
                        case .failure(let error):
                            print(error)
                            
                        }
                    }
                }
                
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
}

extension OurFriendsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ourFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondElementMenu") as? SecondElementTableViewCell {
            
            cell.object = ourFriends[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
extension OurFriendsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let next: ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileVC
        next.id = ourFriends[indexPath.row].id
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}
