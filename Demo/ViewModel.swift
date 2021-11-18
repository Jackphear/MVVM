//
//  ViewModel.swift
//  Demo
//
//  Created by 王韬 on 2021/11/18.
//

import Foundation

class ViewModel {
//    var uniquekey: Obserable<String>
//    var title: Obserable<String>
//    var date: Obserable<String>
//    var category: Obserable<String>
//    var author_name: Obserable<String>
//    var url: Obserable<String>
//    var thumbnail_pic_s: Obserable<String>
//    var thumbnail_pic_s02: Obserable<String>
//    var is_content: Obserable<String>
//
//    required init(model: NewsData) {
//        uniquekey = Obserable(value: model.uniquekey)
//        title = Obserable(value: model.title)
//        date = Obserable(value: model.date)
//        category = Obserable(value: model.category)
//        author_name = Obserable(value: model.author_name)
//        url = Obserable(value: model.url)
//        thumbnail_pic_s = Obserable(value: model.thumbnail_pic_s)
//        thumbnail_pic_s02 = Obserable(value: model.thumbnail_pic_s02)
//        is_content = Obserable(value: model.is_content)
//    }
    var model: Obserable<NewsData>
    required init(model: NewsData) {
        self.model = Obserable(value: model)
    }
}

class Obserable<T> {
    typealias ObserableType = (T) -> Void
    var value: T {
        didSet {
            observer?(value)
        }
    }

    var observer: (ObserableType)?
    func bind(to observer: @escaping ObserableType) {
        self.observer = observer
        observer(value)
    }

    init(value: T) {
        self.value = value
    }
}
