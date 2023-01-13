//
//  ImageLoader.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import Foundation
import UIKit.UIImage
final class ImageLoader {
    public static let shared = ImageLoader()
    
    private let cache: ImageCacheType
    
    private init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }
    
    func image(with name: String, folder: String, completion: @escaping (UIImage?) -> Void) {
        
        if let image = self.cache[name] {
            completion(image)
            return
        }
        guard let resourceURL = URL(string: "\(apiHostname)/Pictures/\(folder)/\(name)") else {
            fatalError("Unable to createURL")
        }
        getData(from: resourceURL) { data, _, error in
            guard let data = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            self.cache[name] = image //Add to cache
            completion(image)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
