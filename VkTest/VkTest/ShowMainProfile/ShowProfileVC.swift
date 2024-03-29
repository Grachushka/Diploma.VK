//
//  ShowProfileVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 17/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import WebKit

class ShowProfileVC: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    private let mainMenu = DataBase.shared.getMainMenu()
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private var secondMenu: MainProfile? {
        
        didSet {
            
            activity.stopAnimating()
            
            table.reloadData()
        }
    }
    
    private func configTable() {
        
        table.register(UINib(nibName: "ElementMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "ElementMenu")
        
        table.register(UINib(nibName: "SecondElementTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondElementMenu")
        
        table.tableFooterView = UIView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity.startAnimating()
        
        configTable()
        
        NetworkManager.shared.getInfoAboutMyProfile(id: "") { result in
            
            switch result {
                
            case .success(let mainProfile):
                
                self.secondMenu = mainProfile.response[0]
                
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 60.0
            
        }
        return 50.0
    }
}

extension ShowProfileVC: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return mainMenu.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondElementMenu") as? SecondElementTableViewCell {
                
                
                cell.object = secondMenu
                cell.discription = "Открыть профиль"
                
                return cell
            } 
            
            return ElementMenuTableViewCell()
        }
        else if indexPath.section == 1 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ElementMenu") as? ElementMenuTableViewCell {
                
                cell.elementMenu = mainMenu[indexPath.row]
                
                
                return cell
            }
            
            return ElementMenuTableViewCell()
            
        }
        
        
        return UITableViewCell()
    }
    
    
}


extension ShowProfileVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath == IndexPath(item: 1, section: 1) {
            
            let next: GroupsVC = self.storyboard?.instantiateViewController(withIdentifier: "GroupsVC") as! GroupsVC
            next.id = "\(secondMenu!.id)"
            self.navigationController?.pushViewController(next, animated: true)        
        } else if indexPath == IndexPath(item: 0, section: 1) {
            
            let next: ShowFriendsVC = self.storyboard?.instantiateViewController(withIdentifier: "friends") as! ShowFriendsVC
            next.id = secondMenu!.id
            self.navigationController?.pushViewController(next, animated: true)            
            
        } else if indexPath == IndexPath(item: 0, section: 0) {
            
            let next: ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileVC
            next.id = secondMenu!.id
            next.isMe = true
            self.navigationController?.pushViewController(next, animated: true)
            
            
        }
    }
}


