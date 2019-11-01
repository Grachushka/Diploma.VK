//
//  GroupsVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 29.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    

    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var responseGroups: ResponseGroups? {
        
        didSet {
            
            if let groups = responseGroups?.response?.items {
                
                self.groups = groups
            }
        }
    }
    
    var groups: [Group] = [] {
        
        didSet {
            
            activity.stopAnimating()
            table.reloadData()
            table.isHidden = false
        }
    }
    
    var id: String?
    
    func config() {
        
        table.register(UINib(nibName: "SecondElementTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondElementMenu")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        table.isHidden = true
        NetworkManager.shared.getGroups(id: id!) { result in

            switch result {

            case .success(let responseGroups):
                 

                self.responseGroups = responseGroups
                

            case .failure(let error):
                
              print(error)

            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        
        NetworkManager.shared.getGroups(id: id!) { result in

            switch result {

            case .success(let responseGroups):
                 

                self.responseGroups = responseGroups
            

            case .failure(let error):
                
              print(error)

            }
        }
    }
}

extension GroupsVC: UITableViewDelegate {
    
    
}

extension GroupsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondElementMenu") as? SecondElementTableViewCell {
            
            if let name = groups[indexPath.row].name {
                
                cell.name = name
            }
         
            cell.imageName = groups[indexPath.row].photo200
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}
