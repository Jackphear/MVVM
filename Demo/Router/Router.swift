//
//  Router.swift
//  Demo
//
//  Created by 王韬 on 2021/11/20.
//

import UIKit

protocol RouterProtocol {
    static func targetWith(pa: [String: Any]) -> RouterProtocol?
    func isPush() -> Bool
}

extension RouterProtocol {
    func isPush() -> Bool {
        return true
    }
}

class Router {
    private let httpString = "http,httpss"
    var targetDic = [String: RouterProtocol.Type]()
    let appScheme = "router"
    static let shared = Router()
    private init() {}

    func registerRouter(target: RouterProtocol.Type, key: String) {
        targetDic.updateValue(target, forKey: key)
    }

    func targetWith(url: String, externParameter: [String: Any]? = nil) -> RouterProtocol? {
        let encodeUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let urlComponents = URLComponents(string: encodeUrl) {
            let scheme = urlComponents.scheme ?? ""
            let host = urlComponents.host ?? ""
            let path = urlComponents.path
            var parameter = [String: Any]()
            if let queryItems = urlComponents.queryItems {
                for query in queryItems {
                    parameter.updateValue(query.value ?? "", forKey: query.name)
                }
            }
            if let externDic = externParameter {
                for (key, value) in externDic {
                    parameter.updateValue(value, forKey: key)
                }
            }
            if scheme == appScheme {
                return targetWith(key: host + path, parameter: parameter)
            } else if httpString.contains(scheme) {
                if let target = targetWith(key: host + path, parameter: parameter) {
                    return target
                }
            }
        }

        return nil
    }

    func targetWith(key: String, parameter: [String: Any]) -> RouterProtocol? {
        if let router = targetDic[key] {
            return router.targetWith(pa: parameter)
        }
        return nil
    }
}
