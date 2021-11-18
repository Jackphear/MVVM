//
//  NewsTableViewCell.swift
//  Demo
//
//  Created by 王韬 on 2021/11/18.
//

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.with(style: .title)
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 70, width: 50, height: 20))
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 70, width: 50, height: 20))
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 150, y: 70, width: 50, height: 20))
        return label
    }()
    
    lazy var rightimageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 300, y: 15, width: 100, height: 70))
        return view
    }()
    
    private func configUI(with data: NewsData) {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ make in
            make.height.equalTo(titleLabel.setSize(with: data.title))
            make.width.equalTo(270)
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(20)
        }
        contentView.addSubview(sourceLabel)
        sourceLabel.snp.makeConstraints{ make in
            make.height.equalTo(titleLabel.setSize(with: data.author_name))
            make.width.equalTo(70)
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview().offset(20)
        }
        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints{ make in
            make.height.equalTo(titleLabel.setSize(with: data.category))
            make.width.equalTo(50)
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview().offset(100)
        }
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints{ make in
            make.height.equalTo(titleLabel.setSize(with: data.date))
            make.width.equalTo(50)
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview().offset(150)
        }
        self.rightimageView.setImage(with: data.thumbnail_pic_s)
        contentView.addSubview(rightimageView)
        rightimageView.snp.makeConstraints{ make in
            make.width.equalTo(100)
            make.right.top.bottom.equalToSuperview()
        }
    }
    
    
}
extension NewsTableViewCell {
    var obModel:Obserable<NewsData>.ObserableType {
        return {value in
            self.configUI(with: value)
        }
    }
}
