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
    private var arrayElementProfileMenu: [ElementMenu] = []
    private var arrayElementInfoMenu: [ElementMenu] = []
    private var arraySettingsMenu: [ElementMenu] = []

    
    
    func getSettingsMenu() -> [ElementMenu]{
        
        if arraySettingsMenu.isEmpty {
            
            setSettingsMenu()
            
        }
        return arraySettingsMenu
    }
    

    func setSettingsMenu() {
        
        arraySettingsMenu.append(ElementMenu(name: "Уведомления", picture: "notification"))
        arraySettingsMenu.append(ElementMenu(name: "Не беспокоить", picture: "doNotDistrub"))
        arraySettingsMenu.append(ElementMenu(name: "Профиль", picture: "profileSettings"))
        arraySettingsMenu.append(ElementMenu(name: "Вид", picture: "view"))
        arraySettingsMenu.append(ElementMenu(name: "Общие", picture: "general"))
        arraySettingsMenu.append(ElementMenu(name: "Приватность", picture: "privacy"))
        arraySettingsMenu.append(ElementMenu(name: "Чёрный список", picture: "blocked"))
        arraySettingsMenu.append(ElementMenu(name: "Баланс", picture: "balance"))
        arraySettingsMenu.append(ElementMenu(name: "Музыкальные подписки", picture: "music"))
        arraySettingsMenu.append(ElementMenu(name: "О нас", picture: "about"))



    }
    
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
    
    func getProfileMenu() -> [ElementMenu] {
        
        if arrayElementProfileMenu.isEmpty {
            
            setProfileMenu()
        }
        return arrayElementProfileMenu
    }
    
    func setProfileMenu() {
        
        arrayElementProfileMenu.append(ElementMenu(picture: "друзей"))
        arrayElementProfileMenu.append(ElementMenu(picture: "общих"))
        arrayElementProfileMenu.append(ElementMenu(picture: "подписчиков"))
        arrayElementProfileMenu.append(ElementMenu(picture: "групп"))
        arrayElementProfileMenu.append(ElementMenu(picture: "фото"))
        arrayElementProfileMenu.append(ElementMenu(picture: "видео"))
        arrayElementProfileMenu.append(ElementMenu(picture: "аудио"))
        arrayElementProfileMenu.append(ElementMenu(picture: "подарков"))
       
    }
    
    func getInfoProfileMenu() -> [ElementMenu]{
        
        if arrayElementInfoMenu.isEmpty {
            
            setArrayElementInfoMenu()
        }
        return arrayElementInfoMenu
    }
    
    func setArrayElementInfoMenu() {
        
        arrayElementInfoMenu.append(ElementMenu(picture: "День рождения "))
        arrayElementInfoMenu.append(ElementMenu(picture: "Родной город"))
        arrayElementInfoMenu.append(ElementMenu(picture: "Место учёбы"))
        arrayElementInfoMenu.append(ElementMenu(picture: "Семейное положение"))
        arrayElementInfoMenu.append(ElementMenu(picture: "Языки"))
    }
    
    
    
    
    
  
}
