//
//  ImageTool.swift.swift
//  Demo
//
//  Created by 王韬 on 2021/11/19.
//

import Foundation
import UIKit

class ImageTool: NSObject {
    static let shared = ImageTool()

    override private init() {
        cache = NSCache<AnyObject, AnyObject>()
    }

    typealias imageHandler = (_ image: UIImage?, _ url: String) -> Void

    private var cache: NSCache<AnyObject, AnyObject>
}

extension ImageTool {
    public func setImageWithUrl(url: String, handler: @escaping imageHandler) {
        if let image = cache.object(forKey: url as AnyObject) as? UIImage {
            print(image)
            DispatchQueue.main.async {
                handler(image, url)
            }
            return
        } else {
            let filePath = NSHomeDirectory().appending("/Documents/").appending(url)
            if let image = UIImage(contentsOfFile: filePath) {
                DispatchQueue.main.async {
                    handler(image, url)
                }
                cache.setObject(image, forKey: url as AnyObject)
            } else {
                let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                    if error != nil {
                        handler(nil, url)
                        return
                    } else {
                        let image = UIImage(data: data!)!
                        self.cache.setObject(image, forKey: url as AnyObject)
                        DispatchQueue.main.async {
                            handler(image, url)
                        }
                        let filePath = NSHomeDirectory().appending("/Documents/").appending(url)
                        let imageData = image.jpegData(compressionQuality: 400) as NSData?
                        imageData?.write(toFile: filePath, atomically: true)
                        return
                    }
                }
                downloadTask.resume()
            }
        }
    }
    
    private func Decoded(image: UIImage) {
        
    }
}
