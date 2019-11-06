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
    
    @IBOutlet weak var friendSearchBar: UISearchBar!
    @IBOutlet weak var toolbarFriendsCurrentOnline: UIBarButtonItem!
    @IBOutlet weak var toolbarFriendsCount: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var barButtonItem: UIBarButtonItem?
    
    var id: Int?
    
    private var friends: [Friend]  = []{
        
        didSet {
            
            table.reloadData()
            activityIndicator.stopAnimating()
            table.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NetworkManager.shared.getFriends(id: id!) { result in
            
            switch result {
                
            case .success(let friends):
                
                self.friends = friends.response.items
                self.toolbarFriendsCount.title = "\(friends.response.count) друзей"
                
                let orderByOnlineFriends = self.friends.filter { $0.online == 1 }
                self.toolbarFriendsCurrentOnline.title = "\(orderByOnlineFriends.count) онлайн"
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    func configureVC() {
        
        barButtonItem = toolbar.items?.first
        friendSearchBar.placeholder = "Поиск"
        table.isHidden = true
        activityIndicator.startAnimating()
        table.register(UINib(nibName: "SecondElementTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondElementMenu")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureVC()
        
        NetworkManager.shared.getFriends(id: id!) { result in
            
            switch result {
                
            case .success(let friends):
                
                self.friends = friends.response.items
                self.toolbarFriendsCount.title = "\(friends.response.count) друзей"
                
                let orderByOnlineFriends = self.friends.filter { $0.online == 1 }
                self.toolbarFriendsCurrentOnline.title = "\(orderByOnlineFriends.count) онлайн"
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        table.refreshControl = refresh
    }
    
    @objc private func refreshTable() {
        
        NetworkManager.shared.getFriends(id: id!) { result in
            
            switch result {
                
            case .success(let friends):
                
                if self.barButtonItem == self.toolbar.items?.last {
                    
                    let orderByOnlineFriends = friends.response.items.filter { $0.online == 1 }
                    self.friends = orderByOnlineFriends
                    self.toolbarFriendsCurrentOnline.title = "\(orderByOnlineFriends.count) онлайн"
                    
                } else if self.barButtonItem == self.toolbar.items?.first {
                    
                    self.friends = friends.response.items
                    let orderByOnlineFriends = friends.response.items.filter { $0.online == 1 }
                    self.toolbarFriendsCurrentOnline.title = "\(orderByOnlineFriends.count) онлайн"
                }
                
                self.table.refreshControl?.endRefreshing()
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    @IBAction func currentFriends(_ sender: Any) {
        
        barButtonItem = sender as? UIBarButtonItem
        
        NetworkManager.shared.getFriends(id: id!) { result in
            
            switch result {
                
            case .success(let friends):
                
                self.friends = friends.response.items
                self.toolbarFriendsCount.title = "\(friends.response.count) друзей"
                
                let orderByOnlineFriends = self.friends.filter { $0.online == 1 }
                self.toolbarFriendsCurrentOnline.title = "\(orderByOnlineFriends.count) онлайн"
                self.friendSearchBar.text = nil
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    @IBAction func currentOnline(_ sender: Any) {
        
        barButtonItem = sender as? UIBarButtonItem
        self.friendSearchBar.text = nil
        
        let orderByOnlineFriends = friends.filter { $0.online == 1 }
        self.toolbarFriendsCurrentOnline.title = "\(orderByOnlineFriends.count) онлайн"
        
        friends = orderByOnlineFriends
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    
}

extension ShowFriendsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondElementMenu") as? SecondElementTableViewCell {

            cell.object = friends[indexPath.row]
 
            
            return cell
        }
        return UITableViewCell()
    }
    
}

extension ShowFriendsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let next: ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileVC
        next.id = friends[indexPath.row].id
        self.navigationController?.pushViewController(next, animated: true)
    }
}

extension ShowFriendsVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        toolbarFriendsCurrentOnline.isEnabled = false
        toolbarFriendsCount.isEnabled = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
        NetworkManager.shared.getFriends(id: id!) { result in
            
            switch result {
                
            case .success(let friends):
                
                self.friends = friends.response.items
                
                
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.endEditing(true)
        toolbarFriendsCurrentOnline.isEnabled = true
        toolbarFriendsCount.isEnabled = true
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NetworkManager.shared.getFriends(id: id!) { result in
            
            switch result {
                
            case .success(let friends):
                
                if self.barButtonItem == self.toolbar.items?.last {
                    
                    let orderByOnlineFriends = friends.response.items.filter { $0.online == 1 }
                    self.friends = orderByOnlineFriends
                    
                    
                } else if self.barButtonItem == self.toolbar.items?.first {
                    
                    self.friends = friends.response.items
                }
                
                if !searchText.isEmpty {
                    self.friends = self.friends.filter { $0.firstName!.localizedCaseInsensitiveContains("\(searchText)")
                        || $0.lastName!.localizedCaseInsensitiveContains("\(searchText)")
                        || $0.firstName!.localizedCaseInsensitiveContains("\(searchText)")
                        && $0.lastName!.localizedCaseInsensitiveContains("\(searchText)")
                        
                    }
                }
                
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        print(searchText)
    }
}

