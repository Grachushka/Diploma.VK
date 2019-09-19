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
    private var secondArrayElementsMainMenu: [SecondElementMenu] = []
    
    
    func getMainMenu() -> [ElementMenu]{
        
        if arrayElementsMainMenu.isEmpty {
            
            setMainMenu()
            
        }
        return arrayElementsMainMenu
    }
    
    func getSecondMainMenu() -> [SecondElementMenu]{
        
        if secondArrayElementsMainMenu.isEmpty {
            
            setSecondMainMenu()
            
        }
        return secondArrayElementsMainMenu
    }

    func setMainMenu() {
        
        arrayElementsMainMenu.append(ElementMenu(name: "Друзья", picture: "friends"))
        arrayElementsMainMenu.append(ElementMenu(name: "Сообщества", picture: "people"))
    }
    
    func setSecondMainMenu() {
        
        var profile: Welcome?
        
        NetworkManager.shared.getInfoAboutMyProfile { result in
            
            switch result {
                
            case .success(let mainProfile):
                print("Success")
               profile = mainProfile
                
                print(profile?.response[0])
            case .failure(let error):
//                firstName = "request.firstName"
                print(error)
                
            }
        }
        secondArrayElementsMainMenu.append(SecondElementMenu(name: "gg", discription: "Открыть профиль", picture: "friends"))
    }
}
