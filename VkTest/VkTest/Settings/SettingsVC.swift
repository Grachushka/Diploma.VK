//
//  SettingsVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 22.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    private let settings = DataBase.shared.getSettingsMenu()
    @IBOutlet weak var table:
    UITableView!
    
    func config() {
        
        table.register(UINib(nibName: "ElementMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "ElementMenu")
        table.tableFooterView = UIView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    private func sendMessage() {
        
        NotificationCenter.default.post(name: .post, object: nil)
        
    }
    @IBAction func Exit(_ sender: UIButton) {
        sendMessage()
        
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        UIApplication.shared.keyWindow?.rootViewController = loginViewController
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension SettingsVC: UITableViewDelegate {
    
}

extension SettingsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ElementMenu") as? ElementMenuTableViewCell {
            
            cell.elementMenu = settings[indexPath.row]
            
            
            return cell
        }
        
        return UITableViewCell()
    }
}


