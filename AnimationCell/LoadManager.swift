//
//  LoadManager.swift
//  AnimationCell
//
//  Created by Max on 15.01.2024.
//

import Foundation
import UIKit

class ImageLoaderManager {
    
    static let shared = ImageLoaderManager()
    
    private init() {}
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            guard let data = data, error == nil else {
                print("Error loading image from URL: \(url)")
                completion(nil)
                return
            }
            
            // Convert data to UIImage
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Error converting data to UIImage")
                completion(nil)
            }
        }.resume()
    }
}
