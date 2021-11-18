//
//  ViewModel.swift
//  Demo
//
//  Created by 王韬 on 2021/11/18.
//

import Foundation

class ViewModel {
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
