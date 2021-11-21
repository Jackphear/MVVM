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
            DispatchQueue.global(qos: .userInteractive).async {
                let decodeImage = self.DecodedImage(image: image)
                DispatchQueue.main.async {
                    handler(decodeImage, url)
                }
            }
            return
        } else {
            let filePath = NSHomeDirectory().appending("/Documents/").appending(url)
            if let image = UIImage(contentsOfFile: filePath) {
                DispatchQueue.global(qos: .userInteractive).async {
                    let decodeImage = self.DecodedImage(image: image)
                    DispatchQueue.main.async {
                        handler(decodeImage, url)
                    }
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
                        DispatchQueue.global(qos: .userInteractive).async {
                            let decodeImage = self.DecodedImage(image: image)
                            DispatchQueue.main.async {
                                handler(decodeImage, url)
                            }
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
    
    public func DecodedImage(image: UIImage) -> UIImage?{
        guard let cgImage = image.cgImage else { return nil}
        guard let colorSpace = cgImage.colorSpace else { return nil}
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerRow = width * 4
        let ctx = CGContext(data: nil,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        guard let context = ctx else { return nil}
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.draw(cgImage, in: rect)
        guard let drawedImage = context.makeImage() else { return nil}
        let result = UIImage(cgImage: drawedImage, scale: image.scale, orientation: image.imageOrientation)
        return result
    }
}
