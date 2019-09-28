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
    
    private let appId = "7151237"
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
        //let url = "https://api.vk.com/method/users.search?q=П&fields=photo_id,verified,sex,bdate,city,country,home_town,has_photo,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,lists,domain,has_mobile,contacts,site,education,universities,schools,status,last_seen,followers_count,common_count,occupation,nickname,relatives,relation,personal,connections,exports,wall_comments,activities,interests,music,movies,tv,books,games,about,quotes,can_post,can_see_all_posts,can_see_audio,can_write_private_message,can_send_friend_request,is_favorite,is_hidden_from_feed,timezone,screen_name,maiden_name,crop_photo,is_friend,friend_status,career,military,blacklisted,blacklisted_by_me&access_token=40b2db9491b5ac8630a580d64b586cd6fa671ef47f021d835fee6293b0630cf22578e1e40ef0d21634bdf&v=5.52"
        
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
    
    func getFriends(result: @escaping (Result<Friends, Error>) -> Void) {
        
        let url = "\(baseURL)friends.get?fields=nickname,domain,sex,bdate,city,country,timezone,photo_50,photo_100,photo_200_orig,has_mobile,contacts,education,online,relation,last_seen,status,can_write_private_message,can_see_all_posts,can_post,universities&access_token=\(token)&v=5.52"
        
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
    
    func getInfoAboutMyProfile(result: @escaping (Result<RequestMainProfile, Error>) -> Void) {
        
        let url = "\(baseURL)users.get?&fields=photo_id,verified,sex,bdate,city,country,home_town,has_photo,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,domain,has_mobile,contacts,site,education,universities,schools,status,last_seen,followers_count,common_count,occupation,nickname,relatives,relation,personal,connections,exports,activities,interests,music,movies,tv,books,games,about,quotes,can_post,can_see_all_posts,can_see_audio,can_write_private_message,can_send_friend_request,is_favorite,is_hidden_from_feed,timezone,screen_name,maiden_name,crop_photo,is_friend,friend_status,career,military,blacklisted,blacklisted_by_me,can_be_invited_group&access_token=\(token)&v=5.52"
        
 
        AF.request(url).responseData { response in
            
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
            //15333310
            let url="\(baseURL)photos.getAll?&extended=1&owner_id=\(id)&access_token=\(token)&v=5.52"
            // let url="https://api.vk.com/method/photos.getAll?&extended=1&owner_id=15333310&access_token=127e866fb51a71e61e1b2c281b4a2fd6c1424ad559b72985aec5ade40848e93b1992e699fe6d222a66eef&v=5.52"
                       
            
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
    }

