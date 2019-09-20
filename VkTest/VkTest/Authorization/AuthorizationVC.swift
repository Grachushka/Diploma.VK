//
//  AuthorizationVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 16/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class AuthorizationVC: UIViewController, WKNavigationDelegate {
    
    var arrayOfParameters = [String]()
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        
        webView.navigationDelegate = self
        
        NetworkManager.shared.authorization { result in

            switch result {

            case .success(let request):

                self.webView.load(request)
                self.activityIndicator.stopAnimating()

            case .failure(let error):
                print(error)
                self.activityIndicator.stopAnimating()

            }
        }
        
    }
    
   
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if !fragmentItems.isEmpty {
            
            activityIndicator.startAnimating()
            
            webView.isHidden = true
            
            NetworkManager.shared.setUser_id(user_id: Int(fragmentItems["user_id"]!.first!)!)
            NetworkManager.shared.setToken(token: String(fragmentItems["access_token"]!.first!))
            NetworkManager.shared.setExpiresIn(expiresIn: Int(fragmentItems["expires_in"]!.first!)!)
            
            performSegue(withIdentifier: "vc", sender: nil)
            
            activityIndicator.stopAnimating()
            
            
        }
       
        
    }
    
    
    private func splitQuery(_ query: String) -> [String: [String]] {
        
        return query.components(separatedBy: "&").map { $0.components(separatedBy: "=") }.reduce(into: [String: [String]]()) { result, element in
            guard !element.isEmpty,
                let key = element[0].removingPercentEncoding,
                let value = element.count >= 2 ? element[1].removingPercentEncoding : "" else { return }
            var values = result[key, default: [String]()]
            values.append(value)
            result[key] = values
        }
    }
    
    var fragmentItems: [String: [String]] {
        
        guard let fragment = webView.url?.fragment else {
            return [:]
        }
        
        return splitQuery(fragment)
    }
    
 

}





//https://oauth.vk.com/access_token?client_id=7134582&client_secret=A4Z0gNbCUsIpBtzhJPMZ&redirect_uri=&code=7a6fa4dff77a228eeda56603b8f53806c883f011c40b72630bb50df056f6479e52a
//auth.checkPhone

//let url = "https://oauth.vk.com/authorize?client_id=7134582&display=mobile&redirect_uri=&scope=friends,photos,audio,video,stories,pages,status,groups,wall,notifications&response_type=code&v=5.52"



//1) отправляем следующий запрос в вебвью, открывается форма для авторизации: "https://oauth.vk.com/authorize?client_id=7134582&display=mobile&redirect_uri=&scope=friends,photos,audio,video,stories,pages,status,groups,wall,notifications&response_type=token&v=5.52"
//2) после успешной авторизации по данному запросу, получаем с запроса


//https://oauth.vk.com/access_token?client_id=7134582&client_secret=A4Z0gNbCUsIpBtzhJPMZ&redirect_uri=&code=228b93294808120c54

