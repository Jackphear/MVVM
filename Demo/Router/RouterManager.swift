//
//  RouterManager.swift
//  Demo
//
//  Created by 王韬 on 2021/11/21.
//

import UIKit

class RouterManager {
    
    static func registerRouters() {
        let router = Router.shared
        router.registerRouter(target: ViewController.self, key: "home/")
        router.registerRouter(target: WebViewController.self, key: "web/")
    }
    
    static func openUrl(url: String, externParameter: [String: Any]? = nil) {
        if let target = Router.shared.targetWith(url: url, externParameter: externParameter) {
            let isPush = target.isPush()
            if let vc = target as? UIViewController {
                self.openVC(vc: vc, isPush: isPush)
            } else {
                print("没有此模块")
            }
        }
    }
    
    static func openVC(vc: UIViewController, isPush: Bool) {
        if let topVC = UIViewController.topViewController() {
            if isPush {
                if topVC.navigationController != nil {
                    topVC.routerPushToVC(toVC: vc)
                } else {
                    let navi = UINavigationController(rootViewController: vc)
                    topVC.routerPresent(navi, animated: true, completion: nil)
                }
            } else {
                topVC.routerPresent(vc, animated: true, completion: nil)
            }
        }
    }
    
}

extension UIViewController {
    static func topViewController() -> UIViewController? {
        
        let rootVC = (UIApplication.shared.delegate?.window)!!.rootViewController
        return self.topViewController(fromVC: rootVC)
    }
    
    static func topViewController(fromVC: UIViewController?) -> UIViewController? {
        if let presentedVC = fromVC?.presentedViewController {
            return self.topViewController(fromVC: presentedVC)
        }
        else if let navi = fromVC as? UINavigationController {
            return self.topViewController(fromVC: navi.topViewController)
        } else if let tab = fromVC as? UITabBarController {
            return self.topViewController(fromVC: tab.selectedViewController)
        }  else {
            return fromVC
        }
    }
    
    func routerPresent(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        viewControllerToPresent.view.backgroundColor = UIColor.white
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func routerPushToVC(toVC: UIViewController, animated: Bool = true) {
        if let navi = self.navigationController {
            if navi.viewControllers.count == 1 {
                toVC.hidesBottomBarWhenPushed = true
            }
            toVC.view.backgroundColor = UIColor.white
            navi.pushViewController(toVC, animated: animated)
        }
    }

}
