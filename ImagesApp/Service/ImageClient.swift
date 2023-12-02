//
//  ImageClient.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 30/11/2023.
//

import UIKit

protocol ImageClientService {
    func setImage(from url: String, completion: @escaping (UIImage?) -> Void)
}

final class ImageClient {
    
    static let shared = ImageClient()
    private(set) var cachedImageForURL: [String: UIImage]
    
    init() {
        self.cachedImageForURL = [:]
    }
}

extension ImageClient: ImageClientService {
    
    func setImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        if let cacheImage = cachedImageForURL[url] {
            completion(cacheImage)
            print("get with cache")
        }else {
            let link = URL(string: url)!
            URLSession.shared.dataTask(with: link) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }else if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.cachedImageForURL[url] = image
                        completion(self.cachedImageForURL[url])
                        print("get with URL")
                    }
                }
            }.resume()
        }
    }
}

