//
//  ViewController.swift
//  Demo
//
//  Created by 王韬 on 2021/9/14.
//

import SwiftyJSON
import UIKit
import HandyJSON

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
    }

    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        return button
    }()

    @objc func test() {
        let params = ["type": "top", "page": "1", "page_size": "10", "is_filter": "1", "key": "1113811726e766953e642681e1371677"]
        NetworkTool.shared.requestWith(params: params) { response in
            let json = JSON(response)
            let data = JSONDeserializer<Result>.deserializeFrom(json: json.description)!.data
            var viewModel = [ViewModel]()
            for item in data {
                viewModel.append(ViewModel(model: item))
            }
        } error: { _ in
            print("error")
        }
    }
}
