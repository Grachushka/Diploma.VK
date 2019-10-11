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
    
    private let appId = "7165850"
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
    
    func getRecommendFriends(result: @escaping (Result<RecommendFriends, Error>) -> Void) {
        
          let url = "\(baseURL)users.search?fields=photo_id,verified,sex,bdate,city,country,home_town,has_photo,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,lists,domain,has_mobile,contacts,site,education,universities,schools,status,last_seen,followers_count,common_count,occupation,nickname,relatives,relation,personal,connections,exports,wall_comments,activities,interests,music,movies,tv,books,games,about,quotes,can_post,can_see_all_posts,can_see_audio,can_write_private_message,can_send_friend_request,is_favorite,is_hidden_from_feed,timezone,screen_name,maiden_name,crop_photo,is_friend,friend_status,career,military,blacklisted,blacklisted_by_me&access_token=\(token)&v=5.52"
        
        
        AF.request(url).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                
                do {
                    
                    let recommendFriends = try JSONDecoder().decode(RecommendFriends.self, from: data)

                    result(.success(recommendFriends))
                    
                } catch {
                    
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    func FindFriends(findBySymbols: String, result: @escaping (Result<RecommendFriends, Error>) -> Void) {
        
        let url = "\(baseURL)users.search?q=\(findBySymbols)&fields=photo_id,verified,sex,bdate,city,country,home_town,has_photo,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,lists,domain,has_mobile,contacts,site,education,universities,schools,status,last_seen,followers_count,common_count,occupation,nickname,relatives,relation,personal,connections,exports,wall_comments,activities,interests,music,movies,tv,books,games,about,quotes,can_post,can_see_all_posts,can_see_audio,can_write_private_message,can_send_friend_request,is_favorite,is_hidden_from_feed,timezone,screen_name,maiden_name,crop_photo,is_friend,friend_status,career,military,blacklisted,blacklisted_by_me&access_token=\(token)&v=5.52".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        
        AF.request(url).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                
                do {
                    
                    let recommendFriends = try JSONDecoder().decode(RecommendFriends.self, from: data)

                    result(.success(recommendFriends))
                    
                } catch {
                    
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func authorization(result: @escaping (Result<URLRequest, Error>) -> Void) {
        
          let url = "https://oauth.vk.com/authorize?client_id=\(appId)&display=mobile&redirect_uri=&scope=friends,photos,audio,video,stories,pages,status,groups,wall,notifications&response_type=token&v=5.52"
        
        AF.request(url).responseString { response in
            
            switch response.result {
                
            case .success( _):

                    let url = URL(string: url)
                    let request = URLRequest(url: url!)
                    
                    result(.success(request))
            
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getFriends(id: Int, result: @escaping (Result<Friends, Error>) -> Void) {
                
            let url = "\(baseURL)friends.get?&user_id=\(id)&fields=nickname,domain,sex,bdate,city,country,timezone,photo_50,photo_100,photo_200_orig,has_mobile,contacts,education,online,relation,last_seen,status,can_write_private_message,can_see_all_posts,can_post,universities&access_token=\(token)&v=5.52"
         
        
        AF.request(url).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                
                do {
                    
                    let friends = try JSONDecoder().decode(Friends.self, from: data)
                    
                    result(.success(friends))
                    
                } catch {
                    
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
   
    }
    
    func getInfoAboutMyProfile(id: Int, result: @escaping (Result<RequestMainProfile, Error>) -> Void) {
        
        var url: String?
        
        if id == 0 {
            
             url = "\(baseURL)users.get?&fields=photo_id,verified,sex,bdate,city,country,home_town,has_photo,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,domain,has_mobile,contacts,site,education,universities,schools,status,last_seen,followers_count,common_count,occupation,nickname,relatives,relation,personal,connections,exports,activities,interests,music,movies,tv,books,games,about,quotes,can_post,can_see_all_posts,can_see_audio,can_write_private_message,can_send_friend_request,is_favorite,is_hidden_from_feed,timezone,screen_name,maiden_name,crop_photo,is_friend,friend_status,career,military,blacklisted,blacklisted_by_me,can_be_invited_group,counters&access_token=\(token)&v=5.52"

        } else if id != 0 {
            
            url = "\(baseURL)users.get?&user_id=\(id)&fields=photo_id,verified,sex,bdate,city,country,home_town,has_photo,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,domain,has_mobile,contacts,site,education,universities,schools,status,last_seen,followers_count,common_count,occupation,nickname,relatives,relation,personal,connections,exports,activities,interests,music,movies,tv,books,games,about,quotes,can_post,can_see_all_posts,can_see_audio,can_write_private_message,can_send_friend_request,is_favorite,is_hidden_from_feed,timezone,screen_name,maiden_name,crop_photo,is_friend,friend_status,career,military,blacklisted,blacklisted_by_me,can_be_invited_group,counters&access_token=\(token)&v=5.52"
        }
        

        AF.request(url!).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                
                do {

                    let mainProfile = try JSONDecoder().decode(RequestMainProfile.self, from: data)
                    
                    result(.success(mainProfile))
                    
                } catch {
                    
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
        
        func getWallPhotos(id: Int, result: @escaping (Result<Parse123, Error>) -> Void) {

            let url="\(baseURL)photos.getAll?&extended=1&owner_id=\(id)&access_token=\(token)&v=5.52"

            AF.request(url).responseData { response in
                
                switch response.result {
                    
                case .success(let data):
                    
                    do {
                        
                        let profileWallPhotos = try JSONDecoder().decode(Parse123.self, from: data )
                        result(.success(profileWallPhotos))
                        
                    } catch {
                        
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    func getWall(id: Int, result: @escaping (Result<Wall, Error>) -> Void) {
        
        let url="\(baseURL)wall.get?&owner_id=\(id)&extended=1&access_token=\(token)&v=5.52"
let url2="https://api.vk.com/method/wall.get?&access_token=1cb4c504f32895d8d8d94ee43cd000c6921552e473fc5aff98200b2990ad0d5585f830a309e76004ec9e6&v=5.52"
        let url3="https://api.vk.com/method/wall.get?&extended=1&domain=sikorsky95&access_token=56de463bf425579d70dc023059266a6efef9435cdb52ad533031430b207e590252986acf3f618a0d61946&v=5.52"
        
        AF.request(url).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                
                do {
                    
                    let wall = try JSONDecoder().decode(Wall.self, from: data )
                    result(.success(wall))
                    
                } catch {
                    
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

