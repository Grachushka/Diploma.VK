//
//  NetworkManager.swift
//  VkTest
//
//  Created by Pavel Procenko on 14/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    //new appId 7139503
    private let appId = "7134582"
    private var user_id: Int = 0
    private var expiresIn: Int = 0
    private var token = String()
    
    private let baseURL = "https://api.vk.com/method/"
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func setUser_id(user_id: Int){

        self.user_id = user_id
    }
    
    func setToken(token: String) {
        print("token \(token)")
        self.token = token
    }
    
    func setExpiresIn(expiresIn: Int) {
        
        self.expiresIn = expiresIn
    }
    
    func authorization(result: @escaping (Result<URLRequest, Error>) -> Void) {
        
          let url = "https://oauth.vk.com/authorize?client_id=7139503&display=mobile&redirect_uri=&scope=friends,photos,audio,video,stories,pages,status,groups,wall,notifications&response_type=token&v=5.52"
        
        AF.request(url).responseString { response in
            
            switch response.result {
                
            case .success( _):
                
                do {
                    
                    let url = URL(string: url)
                    let request = URLRequest(url: url!)
                    
                     result(.success(request))
                    
                } catch {
                    
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getFriends() {
       let request = "\(baseURL)friends.search?count=1000&fields=photo_50,photo_100,photo_200_orig,online&access_token=\(token)&v=5.52"
        
        
   
    }
    
    func getInfoAboutMyProfile(result: @escaping (Result<Welcome, Error>) -> Void) {
//      let url = "\(baseURL)users.get?&fields=photo_id,verified,sex,bdate,city,country,home_town,has_photo,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,domain,has_mobile,contacts,site,education,universities,schools,status,last_seen,followers_count,common_count,occupation,nickname,relatives,relation,personal,connections,exports,activities,interests,music,movies,tv,books,games,about,quotes,can_post,can_see_all_posts,can_see_audio,can_write_private_message,can_send_friend_request,is_favorite,is_hidden_from_feed,timezone,screen_name,maiden_name,crop_photo,is_friend,friend_status,career,military,blacklisted,blacklisted_by_me,can_be_invited_group&access_token=\(token)&v=5.52".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://api.vk.com/method/users.get?&fields=photo_id&access_token=7bd4337932e43a421d594ce508ab01c59308de00eeba7706d7e7065d148962aa2f0d3abd3aced71a2045a&v=5.52"
 
        AF.request(url).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                
                do {
                    //   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

                    let mainProfile = try JSONDecoder().decode(Welcome.self, from: data)
                    
                    result(.success(mainProfile))
                    
                } catch {
                    
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getMyPhotos() {
        //https://api.vk.com/method/photos.getAll?&access_token=4beca86af6328e7795445a9c985d517b8f57d4748cebf1c3f7d9aab4be21b95b46726976a872056dc1bda&v=5.52
        
        
       
    }
    
    
}








//https://api.vk.com/method/users.get?&fields=photo_id,verified,sex,bdate,city,country,home_town,has_photo,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,domain,has_mobile,contacts,site,education,universities,schools,status,last_seen,followers_count,common_count,occupation,nickname,relatives,relation,personal,connections,exports,activities,interests,music,movies,tv,books,games,about,quotes,can_post,can_see_all_posts,can_see_audio,can_write_private_message,can_send_friend_request,is_favorite,is_hidden_from_feed,timezone,screen_name,maiden_name,crop_photo,is_friend,friend_status,career,military,blacklisted,blacklisted_by_me,can_be_invited_group&access_token=c324e62029dc6b4fdb4ba836852193c1eeecad26ddd971b999e8407631f0366291a57cb25dbbbef287a81&v=5.52


//private let privateKey = "A4Z0gNbCUsIpBtzhJPMZ"
//private let serviceKey = "f06360fff06360fff06360ff47f00fbd89ff063f06360ffad1fbe1024ddc76a24792b41"

//let procenkoToken = "af6c4f88d910b40b6763deeea9f0120011b2184b6e8aca439a528332e68e777430808ddba6f57957e38a9"
