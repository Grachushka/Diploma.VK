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
    
    private let appId = "7191775"
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
    
    func getToken() -> String{
        return token
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
    
    func getInfoAboutMyProfile(id: String, result: @escaping (Result<RequestMainProfile, Error>) -> Void) {
        
        var url: String?
        
        if id == "" {
            
             url = "\(baseURL)users.get?&fields=photo_id,verified,sex,bdate,city,country,home_town,has_photo,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,domain,has_mobile,contacts,site,education,universities,schools,status,last_seen,followers_count,common_count,occupation,nickname,relatives,relation,personal,connections,exports,activities,interests,music,movies,tv,books,games,about,quotes,can_post,can_see_all_posts,can_see_audio,can_write_private_message,can_send_friend_request,is_favorite,is_hidden_from_feed,timezone,screen_name,maiden_name,crop_photo,is_friend,friend_status,career,military,blacklisted,blacklisted_by_me,can_be_invited_group,counters&access_token=\(token)&v=5.52"

        } else if id != "" {
            
            url = "\(baseURL)users.get?&user_ids=\(id)&fields=photo_id,verified,sex,bdate,city,country,home_town,has_photo,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,domain,has_mobile,contacts,site,education,universities,schools,status,last_seen,followers_count,common_count,occupation,nickname,relatives,relation,personal,connections,exports,activities,interests,music,movies,tv,books,games,about,quotes,can_post,can_see_all_posts,can_see_audio,can_write_private_message,can_send_friend_request,is_favorite,is_hidden_from_feed,timezone,screen_name,maiden_name,crop_photo,is_friend,friend_status,career,military,blacklisted,blacklisted_by_me,can_be_invited_group,counters&access_token=\(token)&v=5.52"
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
                result(.failure(error))
                print(error)
            }
        }
        
    }
        
        func getWallPhotos(id: Int, result: @escaping (Result<Parse123, Error>) -> Void) {

            let url="\(baseURL)photos.getAll?&extended=1&count=200&owner_id=\(id)&access_token=\(token)&v=5.52"

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
    
    func getReccomendNews(result: @escaping (Result<NewsRealm, Error>) -> Void) {
        
        let url="\(baseURL)newsfeed.getRecommended?&access_token=\(token)&v=5.52"
           let url2="https://api.vk.com/method/newsfeed.getRecommended?&access_token=de5073f79ba950dee893fadd5a834cbf85d3f8554627b4821d396a80c0688ea58a65dd8600de8f8005231&v=5.52"

           AF.request(url).responseData { response in
               
               switch response.result {
                   
               case .success(let data):
                   
                   do {
                       let news = try JSONDecoder().decode(NewsRealm.self, from: data )
                       result(.success(news))
                       
                   } catch {
                       print(error)
                   }
               case .failure(let error):
                result(.failure(error))
                   print(error)
               }
           }
       }
    
    func addToFriend(id: Int, captcha_sid: String, captcha_key: String, result: @escaping (Result<AddFriend, Error>) -> Void) {
        
        var url: String?
        
        if captcha_key == "" {
            
             url="\(baseURL)friends.add?&user_id=\(id)&access_token=\(token)&v=5.52"
            
        } else {
            url="\(baseURL)friends.add?&user_id=\(id)&captcha_sid=\(captcha_sid)&captcha_key=\(captcha_key)&access_token=\(token)&v=5.52"
        }
                   
              AF.request(url!).responseData { response in
                  
                  switch response.result {
                      
                  case .success(let data):
                      
                      do {
                          
                         let newFriend = try JSONDecoder().decode(AddFriend.self, from: data )
                     
                        result(.success(newFriend))
                     
                          
                      } catch {
                        
                          print(error)
                           
                      }
                    
                  case .failure(let error):
                   result(.failure(error))
                      print(error)
                  }
              }
          }
    
    func deleteFriend(id: Int) {
           
           let url="\(baseURL)friends.delete?&user_id=\(id)&access_token=\(token)&v=5.52"
           
              
              AF.request(url).responseData { response in
                  
                  switch response.result {
                      
                  case .success(_): break
                      
                      
                  case .failure(let error):
                      print(error)
                  }
              }
          }
    
    func getOurFriends(id: Int, result: @escaping (Result<OurFriends, Error>) -> Void) {
     
     let url="\(baseURL)friends.getMutual?&target_uid=\(id)&access_token=\(token)&v=5.52"
     
        
        AF.request(url).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                
                do {
                    
                    let ourFriends = try JSONDecoder().decode(OurFriends.self, from: data )
                    result(.success(ourFriends))
                    
                } catch {
                    print(error)
                }
            case .failure(let error):
             result(.failure(error))
                print(error)
            }
        }
    }
    
    func getFollowers(id: String, result: @escaping (Result<ResultResponseFollower, Error>) -> Void) {
        
        let url="\(baseURL)users.getFollowers?&fields=photo_200&user_id=\(id)&access_token=\(token)&v=5.52"
           
           AF.request(url).responseData { response in
               
               switch response.result {
                   
               case .success(let data):
                   
                   do {
                       
                       let followers = try JSONDecoder().decode(ResultResponseFollower.self, from: data )
                       result(.success(followers))
                       
                   } catch {
                       print(error)
                   }
               case .failure(let error):
                result(.failure(error))
                   print(error)
               }
           }
       }
    
    func getGroups(id: String, result: @escaping (Result<ResponseGroups, Error>) -> Void) {
           
           let url="\(baseURL)groups.get?&extended=1&user_id=\(id)&access_token=\(token)&v=5.52"
              
//        let url2 = "https://api.vk.com/method/groups.get?&extended=1&access_token=a08fb024bee5f18ba09a86eca07ad36b170a1511a64e2515c34d74ce63cc6d59a0c8a24f662b9e27e5fe3&v=5.52"
              AF.request(url).responseData { response in
                  
                  switch response.result {
                      
                  case .success(let data):
                      
                      do {
                          
                          let groups = try JSONDecoder().decode(ResponseGroups.self, from: data )
                          result(.success(groups))
                          
                      } catch {
                          print(error)
                      }
                  case .failure(let error):
                   result(.failure(error))
                      print(error)
                  }
              }
          }
    
    func getPhotos(id: String, result: @escaping (Result<ResponseGroups, Error>) -> Void) {
               
               let url="\(baseURL)groups.get?&extended=1&user_id=\(id)&access_token=\(token)&v=5.52"
                  
    //        let url2 = "https://api.vk.com/method/groups.get?&extended=1&access_token=a08fb024bee5f18ba09a86eca07ad36b170a1511a64e2515c34d74ce63cc6d59a0c8a24f662b9e27e5fe3&v=5.52"
                  AF.request(url).responseData { response in
                      
                      switch response.result {
                          
                      case .success(let data):
                          
                          do {
                              
                              let groups = try JSONDecoder().decode(ResponseGroups.self, from: data )
                              result(.success(groups))
                              
                          } catch {
                              print(error)
                          }
                      case .failure(let error):
                       result(.failure(error))
                          print(error)
                      }
                  }
              }
}

