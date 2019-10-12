//
//  WallCollectionViewCell.swift
//  VkTest
//
//  Created by Pavel Procenko on 07/10/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class WallCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    private weak var pictureTask: URLSessionDataTask?

    var copyHistoryAttachment: CopyHistoryAttachment? {
        
        didSet {
//            URLCache.shared.removeAllCachedResponses()
//            URLCache.shared.diskCapacity = 0
//            URLCache.shared.memoryCapacity = 0
//            URLCache.shared.removeAllCachedResponses()
//            if let cookies = HTTPCookieStorage.shared.cookies {
//                for cookie in cookies {
//                    HTTPCookieStorage.shared.deleteCookie(cookie)
//                }
//            }
            
            if let type = copyHistoryAttachment?.type {

                switch type {
                    
                case .video:
                    print("video")
                case .doc:
                    print("doc")
                    
                  
                    if let imageName = copyHistoryAttachment!.doc!.preview!.photo!.sizes![2].src {
                    let url = URL(string: imageName)
                       print(url!)
                    loadImage(url: url!)
                      
                    }
                    
                case .link:
                    print("link")
                    
                    if let imageName = copyHistoryAttachment!.link!.photo?.photo130 {
                        let url = URL(string: imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                        print(url!)
                        loadImage(url: url!)
                    }
                    
                case .photo:
                    print("photo")
                    
                    if let imageName = copyHistoryAttachment!.photo!.photo130 {
                        let url = URL(string: imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                        print(url!)
                        loadImage(url: url!)
                    }
                    
                case .graffiti:
                    print("graffity")
                case .note:
                    print("note")
                case .app:
                    print("app")
                case .poll:
                    print("poll")
                case .page:
                    print("page")
                case .album:
                    print("album")
                case .photos_list:
                    print("photos_list")
                case .market:
                    print("market")
                case .market_album:
                    print("market_album")
                case .sticker:
                    print("sticker")
                case .pretty_cards:
                    print("pretty_cards")
                case .event:
                    print("event")
                case .posted_photo:
                    print("posted_photo")
                case .audio:
                    print("audio")
                
                }
            }
        }
    }
    
    
//    func loadImage(url: URL) {
//
//        imageView.kf.setImage(with: url)
//            {
//                result in
//                switch result {
//
//                case .success(_):
//                    print("success")
//                case .failure(let error):
//                    print(error)
//
//            }
//        }
//    }
//    func loadImage(url: URL) {
//        loadPhoto(url: url) { result in
//            switch result {
//            case .success(let data ):
//
//                self.imageView.image = data
//
//            case .failure(let error):
//                print(error)
//            }
//
//        }
//    }
//}
//
//func loadPhoto(url: URL, result: @escaping (Result<UIImage, Error>) -> Void) {
//
//
//
//    AF.request(url).responseData { response in
//
//        switch response.result {
//
//        case .success(let data):
//
//
//
//             let image = UIImage(data: data)
//                result(.success(image!))
//
//
//        case .failure(let error):
//            print(error)
//        }
//    }
//
//}
    func loadImage(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
        pictureTask = task
        task.resume()
    }
    override func prepareForReuse() {
        
        pictureTask?.cancel()
        imageView = nil
    }
}
