//
//  NetworkCallManager.swift
//  Pago
//
//  Created by radu on 10.02.2024.
//

import UIKit

final class NetworkCallManager {
    
    static let shared = NetworkCallManager()
    private let cache = NSCache<NSString, UIImage>()
    private let contactsURL = "https://gorest.co.in/public/v2/users"
    private init() {}
    
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void ) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                completed(image)
            }
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
