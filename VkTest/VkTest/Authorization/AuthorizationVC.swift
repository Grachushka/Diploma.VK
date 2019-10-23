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
    
    deinit {
              NotificationCenter.default.removeObserver(self)
          }
    func observePost() {
        
           NotificationCenter.default.addObserver(self, selector: #selector(messageReceived(_:)), name: .post, object: nil)
          
       }
      @objc
        private func messageReceived(_ notification: Notification){
        
            webView.cleanAllCookies()
            webView.refreshCookies()
            
        }
    
    
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        observePost()
    
        activityIndicator.startAnimating()
        
        webView.navigationDelegate = self
        
        NetworkManager.shared.authorization { result in

            switch result {

            case .success(let request):

                self.webView.load(request)
                self.activityIndicator.stopAnimating()
             
              

            case .failure(let error):
                print(error)

            }
        }
    }
   
    
   
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if !fragmentItems.isEmpty {
                        
            webView.isHidden = true
         
            NetworkManager.shared.setUser_id(user_id: Int(fragmentItems["user_id"]!.first!)!)
            NetworkManager.shared.setToken(token: String(fragmentItems["access_token"]!.first!))
            NetworkManager.shared.setExpiresIn(expiresIn: Int(fragmentItems["expires_in"]!.first!)!)
            
            performSegue(withIdentifier: "vc", sender: webView)
            
                        
            
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

extension WKWebView {

    func cleanAllCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("All cookies deleted")

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("Cookie ::: \(record) deleted")
            }
        }
    }

    func refreshCookies() {
        self.configuration.processPool = WKProcessPool()
    }
}


extension Notification.Name {
    
    static let post = Notification.Name("Post")
}
