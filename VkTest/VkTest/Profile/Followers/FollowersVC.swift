//
//  FollowersVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 27.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class FollowersVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var id: String?
    
    var followerResponse: ResultResponseFollower? {
        
        didSet {
            if let followers = followerResponse?.response?.items {
                
                self.followers = followers

            }
        }
    }
    
    var followers: [Follower] = [] {
        
        didSet {
            
            table.reloadData()

        }
    }
    
    func config() {
        
        table.register(UINib(nibName: "SecondElementTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondElementMenu")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NetworkManager.shared.getFollowers(id: id!) { result in

                   switch result {

                   case .success(let followerResponse):

                       self.followerResponse = followerResponse
                       
                   case .failure(let error):
                       print(error)

                   }
               }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        NetworkManager.shared.getFollowers(id: id!) { result in

            switch result {

            case .success(let followerResponse):

                self.followerResponse = followerResponse
                
            case .failure(let error):
                print(error)

            }
        }
    }
    
}

extension FollowersVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let next: ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileVC
        next.id = followers[indexPath.row].id
                 self.navigationController?.pushViewController(next, animated: true)

    }
}

extension FollowersVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return followers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondElementMenu") as? SecondElementTableViewCell {
                    cell.name = "\(followers[indexPath.row].firstName!) \(followers[indexPath.row].lastName!)"
                    
        cell.imageName = followers[indexPath.row].photo200
        
         
                    
        //            if ourFriends[indexPath.row].online == 1 {
        //
        //                cell.isOnlineFromMobile = false
        //
        //            }
                    
                    return cell
                }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
