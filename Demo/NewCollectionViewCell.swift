//
//  NewCollectionViewCell.swift
//  Demo
//
//  Created by 王韬 on 2021/10/18.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews(){
        super.layoutSubviews()
        self.contentView.addSubview(label)
    }
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "333"
        label.backgroundColor = .red
        return label
    }()
    
}
