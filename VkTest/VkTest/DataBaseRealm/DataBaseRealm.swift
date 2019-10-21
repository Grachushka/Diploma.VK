//
//  DataBaseRealm.swift
//  VkTest
//
//  Created by Pavel Procenko on 16.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation
import RealmSwift

class DataBaseRealmSwift {
    
private lazy var realm = try! Realm()
   
   private init() {}

   static let shared = DataBaseRealmSwift()
    
    func getNews() ->  Results<NewsRealm>! {

        return realm.objects(NewsRealm.self)
      }
    
    func addNews(news: NewsRealm) {
           try! realm.write {
            
               realm.add(news)
           }
       }
}

