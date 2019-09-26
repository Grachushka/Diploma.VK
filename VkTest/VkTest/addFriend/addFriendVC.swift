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

            cell.name = "\(recommendFriends[indexPath.row].firstName!) \(recommendFriends[indexPath.row].lastName!)"
                   cell.imageName = recommendFriends[indexPath.row].photo200_Orig
                   cell.discription = "Москва\nОбщих друзей: \(recommendFriends[indexPath.row].commonCount!)"
                   if recommendFriends[indexPath.row].online == 1 && recommendFriends[indexPath.row].onlineMobile == 1 {

                       cell.isOnlineFromMobile = true
                       
                   } else if recommendFriends[indexPath.row].online == 1 && recommendFriends[indexPath.row].onlineMobile == nil {
                       
                       cell.isOnlineFromMobile = false
                       
                   }
                   
                let url = URL(string: recommendFriends[indexPath.row].photo200_Orig!)
                   cell.loadPictureImage(url: url!)
               
                   return cell
               }
               return UITableViewCell()
    }
}

extension addFriendVC: UITableViewDelegate {
    
}

extension addFriendVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = nil
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        table.isHidden = true
        
        activityIndicator.isHidden = false
        
        NetworkManager.shared.getRecommendFriends { result in
            
            switch result {
                
            case .success(let recommendFriends):
                
                self.recommendFriends = recommendFriends.response.items
               
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NetworkManager.shared.FindFriends(findBySymbols: searchText ) { result in
            
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
