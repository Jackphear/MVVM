//
//  Extension.swift
//  Demo
//
//  Created by 王韬 on 2021/11/18.
//

import Foundation
import UIKit

enum LabelStyle {
    case title
    case subTitle
}

extension UILabel {
    static func with(style initalStyle: LabelStyle) -> UILabel {
        switch initalStyle {
        case .title:
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .black
            label.numberOfLines = 2
            label.lineBreakMode = .byTruncatingTail
            return label
        case .subTitle:
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .gray
            return label
        }
    }

    func setSize(with text: String) -> CGFloat {
        self.text = text
        let size = sizeThatFits(CGSize(width: 300, height: CGFloat(MAXFLOAT)))
        return size.height + 1
    }
}

extension UIImageView {
    func setImage(with url: String) {
        let URL = URL(string: url)!
        image = UIImage(named: "1")
        let downloadQueue = DispatchQueue.global(qos: .default)
        let mainQueue = DispatchQueue.main
        downloadQueue.async {
            var modelImage: UIImage?
            do {
                modelImage = UIImage(data: try Data(contentsOf: URL))
            } catch {
                fatalError()
            }
            mainQueue.async {
                self.image = modelImage
            }
        }
    }
}
