//
//  ImageService.swift
//  FitnessApp
//
//  Created by Allan on 1.07.23.
//

import Foundation
import UIKit

final class ImageService: ImageServiceProtocol {
    
    func saveImageToFileManager(profileImage: UIImage) -> String {
        let image = profileImage
        var relativePath: String = ""
        let queue = DispatchQueue(label: "ImageDownloadQueue", qos: .default)
        //Convert to Data
        if let data = image.pngData() {
            // Create URL
            relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate).jpg"
            queue.async {
                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let url = documents.appendingPathComponent(relativePath)
                do {
                    // Write to Disk
                    try data.write(to: url)
                } catch {
                    print("Unable to Write Data to Disk (\(error))")
                }
            }
        }
        return relativePath
    }

    func loadPhotoBy(relativePath: String?, completion: @escaping ((UIImage?) -> Void)) /* -> UIImage? */{
        var image: UIImage?
        let queue = DispatchQueue(label: "ImageDownloadQueue", qos: .userInteractive)
        if let relativePath = relativePath {
            queue.sync {
                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let url = documents.appendingPathComponent(relativePath)
                image = downloadImage(url: url)
                completion(image)
            }
        }
//        return image
    }
    
    func downloadImage(url: URL?) -> UIImage?{
        if let url = url,
           let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return UIImage(named: "default-profile-image")
    }
}
