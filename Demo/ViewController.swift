//
//  ViewController.swift
//  Demo
//
//  Created by 王韬 on 2021/9/14.
//

import HandyJSON
import SwiftyJSON
import UIKit

class ViewController: UIViewController {
    var viewModel = [ViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configDataFromNetwork()
        view.addSubview(tableView)
        let label = FPSLabel()
        view.addSubview(label)
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    func configDataFromNetwork() {
        let params = ["type": "top", "page": "1", "page_size": "20", "is_filter": "1", "key": "1113811726e766953e642681e1371677"]
        NetworkTool.shared.requestWith(params: params) { response in
            let json = JSON(response)
            let data = JSONDeserializer<Result>.deserializeFrom(json: json.description)!.data
            for item in data {
                self.viewModel.append(ViewModel(model: item))
            }
            self.tableView.reloadData()
        } error: { _ in
            print("error")
        }
    }

    func configDataFromLocal() {
        let path = Bundle.main.path(forResource: "data", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        let json = JSON(jsonData!)
        let data = JSONDeserializer<Result>.deserializeFrom(json: json.description)!.data
        for item in data {
            viewModel.append(ViewModel(model: item))
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewsTableViewCell
        viewModel[indexPath.row].model.bind(to: cell.obModel)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
