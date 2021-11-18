//
//  ViewModel.swift
//  Demo
//
//  Created by 王韬 on 2021/11/18.
//

import HandyJSON
import UIKit

struct Result: HandyJSON {
    var stat = ""
    var data = [NewsData]()
    var page = ""
    var pageSize = ""
}

struct NewsData: HandyJSON {
    var uniquekey = ""
    var title = ""
    var date = ""
    var category = ""
    var author_name = ""
    var url = ""
    var thumbnail_pic_s = ""
    var thumbnail_pic_s02 = ""
    var is_content = ""
}

