//
//  DataBase.swift
//  VkTest
//
//  Created by Pavel Procenko on 17/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation

class DataBase {
    
    static let shared = DataBase()
    
    private init() {}
    private var arrayElementsMainMenu: [ElementMenu] = []
    
    
    
    func getMainMenu() -> [ElementMenu]{
        
        if arrayElementsMainMenu.isEmpty {
            
            setMainMenu()
            
        }
        return arrayElementsMainMenu
    }
    

    func setMainMenu() {
        
        arrayElementsMainMenu.append(ElementMenu(name: "Друзья", picture: "friends"))
        arrayElementsMainMenu.append(ElementMenu(name: "Сообщества", picture: "people"))
    }
    
  
}
