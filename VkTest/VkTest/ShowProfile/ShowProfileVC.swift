//
//  ShowProfileVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 17/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class ShowProfileVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    private let mainMenu = DataBase.shared.getMainMenu()
    private let secondMenu = DataBase.shared.getSecondMainMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UINib(nibName: "ElementMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "ElementMenu")
        
        table.register(UINib(nibName: "SecondElementTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondElementMenu")
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

extension ShowProfileVC: UITableViewDataSource {



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch section {
        case 0:
            return secondMenu.count
        case 1:
            return mainMenu.count
        default:
            return 0
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondElementMenu") as? SecondElementTableViewCell {
                
                cell.secondElementMenu = secondMenu[indexPath.row]
                
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

}


