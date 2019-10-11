//
//  InfoVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 04/10/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {

 
    
    @IBOutlet weak var table: UITableView!
    var arrayInfo = DataBase.shared.getInfoProfileMenu()
    var object: MainProfile?
    
    func config() {
        
        table.register(UINib(nibName: "SecondElementTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondElementMenu")
        table.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        if let familyStatus = object?.relation {
            
            var value: String?
            
            switch familyStatus {
                
            case 1: value = "не женат/не замужем"
            case 2: value = "есть друг/подруга"
            case 3: value = "помолвлен/помолвлена"
            case 4: value = "женат/замужем"
            case 5: value = "все сложно"
            case 6: value = "в активном поиске"
            case 7: value = "влюблен/влюблена"
            case 8: value = "влюблен/влюблена"
            
            default: value = ""
                
            }
            self.arrayInfo[3].name = "\(value!)"
        }
        if let bdate = object?.bdate {
                          
            self.arrayInfo[0].name = "\(bdate)"
                          
        }
        
        if let country = object?.city?.title {
                               
            self.arrayInfo[1].name = "\(country)"
                               
        }
        
        if let university = object?.universityName {
                               
            self.arrayInfo[2].name = "\(university)"
                               
        }
        
        if let langs = object?.personal?.langs {
            
            self.arrayInfo[4].name = langs.joined(separator: ",")
                                      
        }
        
        
        
        self.arrayInfo = self.arrayInfo.filter { $0.name != nil && $0.name != ""}
        table.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 60
            
        }
        
        return 50
    }
    
}

extension InfoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         switch section {
            case 0:
                return 1
            case 1:
                return arrayInfo.count
            default:
                return 0
               }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondElementMenu") as? SecondElementTableViewCell {
                           
            if let firstName = object?.firstName, let lastName = object?.lastName {
                cell.name = "\(firstName) \(lastName)"
                }
                cell.discription = nil
                cell.imageName = object?.photo100
                
                return cell
                
            }
            
        } else if indexPath.section == 1 {
           
            if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell") as? InfoTableViewCell {
                
                cell.named = arrayInfo[indexPath.row].picture
                cell.valued = arrayInfo[indexPath.row].name
                
                
                return cell
                
            }
            
        }
    
    return UITableViewCell()
        
    }
}

extension InfoVC: UITableViewDelegate {
    
}
