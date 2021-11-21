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

    @discardableResult
    func added(into superView: UIView) -> UILabel {
        superView.addSubview(self)
        return self
    }

    func setSize(with text: String) -> CGFloat {
        print("")
        self.text = text
        let size = sizeThatFits(CGSize(width: 200, height: CGFloat(MAXFLOAT)))
        return size.height + 1
    }
}

extension String {
    func urlEncoding() -> String {
        let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
        let unreservedCharset = CharacterSet(charactersIn: unreservedChars)
        return addingPercentEncoding(withAllowedCharacters: unreservedCharset) ?? self
    }

    func urlDecoding() -> String {
        return removingPercentEncoding ?? self
    }

    func base64Encoding() -> String {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return self
    }

    func base64Decoding() -> String {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8) ?? ""
        }
        return self
    }
}
