//
//  addFriendVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 26/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class addFriendVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var recommendFriends: [RecommendFriend]  = []{
        
        didSet {
            
            table.reloadData()
            activityIndicator.stopAnimating()
            table.isHidden = false
            searchBar.placeholder = "Поиск"
        }
    }
    private func config() {
        
        table.register(UINib(nibName: "SecondElementTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondElementMenu")
        table.isHidden = true
        table.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NetworkManager.shared.getRecommendFriends { result in
            
            switch result {
                
            case .success(let recommendFriends):
                
                self.recommendFriends = recommendFriends.response.items
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        
        NetworkManager.shared.getRecommendFriends { result in
            
            switch result {
                
            case .success(let recommendFriends):
                
                self.recommendFriends = recommendFriends.response.items
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
            return "Рекомендации"
        }
        return ""
    }
    
    
}

extension addFriendVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        recommendFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondElementMenu") as? SecondElementTableViewCell {
            
            cell.object = recommendFriends[indexPath.row]
           
           
            
            return cell
        }
        return UITableViewCell()
    }
}

extension addFriendVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let next: ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileVC
        next.id = recommendFriends[indexPath.row].id
        self.navigationController?.pushViewController(next, animated: true)
    }
}

extension addFriendVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = nil
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        //table.isHidden = true
        
       // activityIndicator.isHidden = false
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NetworkManager.shared.findFriends(findBySymbols: searchText ) { result in
            
            switch result {
                
            case .success(let recommendFriends):
                
                self.recommendFriends = recommendFriends.response.items
                
            case .failure(let error):
                print(error)
                
            }
        }
        print(searchText)
    }
    
}
