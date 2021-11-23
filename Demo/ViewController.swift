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
        configDataFromLocal()
        view.addSubview(tableView)
        (UIApplication.shared.delegate?.window)!!.rootViewController?.view.addSubview(label)
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    lazy var label: FPSLabel = {
        let fpsLabel = FPSLabel(frame: CGRect(x: UIScreen.main.bounds.width - 60.0, y:UIScreen.main.bounds.height - 25.0 , width: 40.0, height: 20.0))
        return fpsLabel
    }()

    func configDataFromNetwork() {
        let params = ["type": "top", "page": "1", "page_size": "30", "is_filter": "1", "key": "1113811726e766953e642681e1371677"]
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
        let webUrl = viewModel[indexPath.row].model.value.url
        let openUrl = "http://web/?url=\(webUrl)"
        RouterManager.openUrl(url: openUrl)
    }
    
}

extension ViewController: RouterProtocol {
    static func targetWith(pa: [String : Any]) -> RouterProtocol? {
        let vc = ViewController()
        return vc
    }
}
