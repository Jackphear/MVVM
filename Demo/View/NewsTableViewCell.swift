//
//  NewsTableViewCell.swift
//  Demo
//
//  Created by 王韬 on 2021/11/18.
//

import SnapKit
import UIKit

class NewsTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel.with(style: .title).added(into: contentView)
        return label
    }()

    lazy var sourceLabel: UILabel = {
        let label = UILabel.with(style: .subTitle).added(into: contentView)
        return label
    }()

    lazy var commentLabel: UILabel = {
        let label = UILabel.with(style: .subTitle).added(into: contentView)
        return label
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel.with(style: .subTitle).added(into: contentView)
        return label
    }()

    lazy var rightimageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 300, y: 15, width: 100, height: 70))
        let image = UIImage(named: "1")
        DispatchQueue.global(qos: .userInteractive).async {
            let decodeImage = ImageTool.shared.DecodedImage(image: image!)
            DispatchQueue.main.async {
                view.image = decodeImage
            }
        }
        view.image = UIImage(named: "1")
        return view
    }()

    private func configUI(with data: NewsData) {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(titleLabel.setSize(with: data.title))
            make.width.equalTo(270)
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(20)
        }

        sourceLabel.snp.makeConstraints { make in
            make.height.equalTo(sourceLabel.setSize(with: data.author_name))
            make.width.equalTo(55)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(20)
        }

        commentLabel.snp.makeConstraints { make in
            make.height.equalTo(commentLabel.setSize(with: data.category))
            make.width.equalTo(30)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalTo(sourceLabel.snp.right).offset(10)
        }

        timeLabel.snp.makeConstraints { make in
            make.height.equalTo(timeLabel.setSize(with: data.date))
            make.width.equalTo(140)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalTo(commentLabel.snp.right).offset(10)
        }
//        self.rightimageView.setImage(with: data.thumbnail_pic_s)
        ImageTool.shared.setImageWithUrl(url: data.thumbnail_pic_s) { image, _ in
            self.rightimageView.image = image
        }
        contentView.addSubview(rightimageView)
        rightimageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.right.top.bottom.equalToSuperview()
        }
    }
}

extension NewsTableViewCell {
    var obModel: Obserable<NewsData>.ObserableType {
        return { value in
            self.configUI(with: value)
        }
    }
}
