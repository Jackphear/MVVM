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
        print("")
        self.text = text
        let size = sizeThatFits(CGSize(width: 200, height: CGFloat(MAXFLOAT)))
        return size.height + 1
    }
}
