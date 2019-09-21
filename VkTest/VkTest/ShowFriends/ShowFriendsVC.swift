//
//  ShowFriendsVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 20/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class ShowFriendsVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var toolbarFriendsCurrentOnline: UIBarButtonItem!
    @IBOutlet weak var toolbarFriendsCount: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var barButtonItem: UIBarButtonItem?
    
    
    private var friends: [Friend]  = []{
        
        didSet {
            let orderByOnlineFriends = friends.filter { $0.online == 1 }
            self.toolbarFriendsCurrentOnline.title = "\(orderByOnlineFriends.count) друзей"
            
             
                
            
            table.reloadData()
            activityIndicator.stopAnimating()
            table.isHidden = false
        }
    }
    
    
    @IBAction func currentFriends(_ sender: Any) {
         barButtonItem = sender as? UIBarButtonItem
        
        NetworkManager.shared.getFriends { result in
            
            switch result {
                
            case .success(let friends):
                
                self.friends = friends.response.items
                self.toolbarFriendsCount.title = "\(friends.response.count) друзей"
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    @IBAction func currentOnline(_ sender: Any) {
        barButtonItem = sender as? UIBarButtonItem

        let orderByOnlineFriends = friends.filter { $0.online == 1 }
        friends = orderByOnlineFriends
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barButtonItem = toolbar.items?.first
        
        table.isHidden = true
        activityIndicator.startAnimating()
        table.register(UINib(nibName: "SecondElementTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondElementMenu")
        
        NetworkManager.shared.getFriends { result in
            
            switch result {
                
            case .success(let friends):
                
               self.friends = friends.response.items
               self.toolbarFriendsCount.title = "\(friends.response.count) друзей"
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        table.refreshControl = refresh
    }
    
    @objc private func refreshTable() {
        
        NetworkManager.shared.getFriends { result in
            
            switch result {
                
            case .success(let friends):
                if self.barButtonItem == self.toolbar.items?.last {
                    
                    let orderByOnlineFriends = friends.response.items.filter { $0.online == 1 }
                    self.friends = orderByOnlineFriends
                    //self.friends = orderByOnlineFriends
                } else if self.barButtonItem == self.toolbar.items?.first {
                    
                    self.friends = friends.response.items
                }
                
                self.table.refreshControl?.endRefreshing()
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

extension ShowFriendsVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondElementMenu") as? SecondElementTableViewCell {
            
            cell.name = "\(friends[indexPath.row].firstName) \(friends[indexPath.row].lastName)"
            cell.imageName = friends[indexPath.row].photo200_Orig
            if friends[indexPath.row].online == 1 && friends[indexPath.row].onlineMobile == 1 {

                cell.isOnlineFromMobile = true
                
            } else if friends[indexPath.row].online == 1 && friends[indexPath.row].onlineMobile == nil {
                
                cell.isOnlineFromMobile = false
                
            } 
            
            let url = URL(string: friends[indexPath.row].photo200_Orig)
            cell.loadPictureImage(url: url!)
        
            return cell
        }
        return UITableViewCell()
    }
    
}

extension ShowFriendsVC: UITableViewDelegate {
    
}

