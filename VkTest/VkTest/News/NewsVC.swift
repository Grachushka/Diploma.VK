//
//  NewsVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 14.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    
    var responseNews: ResponseNewsRealm? {
        
        didSet {
            
            if let news = responseNews?.items {
                
                self.news = Array(news)
            }
            
            if let groups = responseNews?.groups{
                
                self.groups = Array(groups)
            }
            
            if let profiles = responseNews?.profiles {
                
                self.profiles = Array(profiles)
            }
        }
    }

    var news: [OneNewsRealm] = [] {
        
        didSet {
            activityIndicator.stopAnimating()
            table.reloadData()
        }
    }
    var groups: [GroupRealm] = []
    var profiles: [ProfileRealm] = []
    
    private func config() {
        
        table.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        //table.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = false
        config()
        
        NetworkManager.shared.getReccomendNews { result in

            switch result {

            case .success(let news):
                 
                DataBaseRealmSwift.shared.addNews(news: news)
                
                self.responseNews = DataBaseRealmSwift.shared.getNews()?.last._rlmInferWrappedType().response
            

            case .failure(let error):
                
                self.responseNews = DataBaseRealmSwift.shared.getNews()?.last._rlmInferWrappedType().response
                print(error)

            }
        }
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        table.refreshControl = refresh
    }
    
    @objc private func refreshTable() {
        
        NetworkManager.shared.getReccomendNews { result in

            switch result {

            case .success(let news):
                
                DataBaseRealmSwift.shared.addNews(news: news)
                               
                self.responseNews = DataBaseRealmSwift.shared.getNews()?.last._rlmInferWrappedType().response
                self.table.refreshControl?.endRefreshing()
            case .failure(let error):
                 self.responseNews = DataBaseRealmSwift.shared.getNews()?.last._rlmInferWrappedType().response
                 self.table.refreshControl?.endRefreshing()
                print(error)

            }
        }
        
    }
}

extension NewsVC: UITableViewDelegate {
    
}

extension NewsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell {
            
            if let description = news[indexPath.row].text {
                
                cell.descriptionPhoto = description
            }
            
            cell.profile = profiles
            cell.groups = groups
            cell.news = news[indexPath.row]
            
            print(news[indexPath.row].attachments.first?.type)
            cell.copyHistoryAttachment = news[indexPath.row].attachments.first
            return cell
        }
        return UITableViewCell()
    }
    
    
    
}
