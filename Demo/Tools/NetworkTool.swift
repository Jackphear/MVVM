//
//  NetworkTool.swift
//  Demo
//
//  Created by 王韬 on 2021/11/18.
//

import Alamofire
import UIKit
import HandyJSON
import SwiftyJSON


typealias NetworkSuccessBlock = (_ response: Any) -> Void

typealias NetworkFailureBlock = (_ error: Any) -> Void

struct NetModel: HandyJSON {
    var reason = "" //失败或者成功
    var result: AnyObject?
    var error_code = 0 // 错误码
}

class NetworkTool: NSObject {
    static let shared = NetworkTool()
    static let api = "http://v.juhe.cn/toutiao/index?"
    override private init() {
    }
}

extension NetworkTool {
    public func requestWith(params: [String: Any]? = nil, success: @escaping NetworkSuccessBlock, error: @escaping NetworkFailureBlock) {
        getRequestWith(url: NetworkTool.api, params: params) { json in
            guard let model = NetModel.deserialize(from: json as? Dictionary) else { return }
            self.handelData(model: model, success: success, error: error)
        } error: { err in
            error(err)
        }
    }
}

extension NetworkTool {
    
    //最接近Alamofire
    private func getRequestWith(url: String, params: [String: Any]? = nil, success: @escaping NetworkSuccessBlock, error: @escaping NetworkFailureBlock) {
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case let .success(value):
                success(value)
            case let .failure(err):
                error(err)
            }
        }
    }
    
    private func handelData(model: NetModel, success: @escaping NetworkSuccessBlock, error: @escaping NetworkFailureBlock) {
        switch model.error_code {
        case 0:
            success(model.result as Any)
        default:
            error(model.reason)
        }
    }
}
