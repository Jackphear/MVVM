//
//  test.swift
//  Demo
//
//  Created by 王韬 on 2021/11/20.
//

import Foundation
import UIKit

class FPSLabel: UILabel {
    var displayLink:CADisplayLink!
    var lastTimeStamp:CFTimeInterval = -1.0
    var countPerFrame:Double = 0.0
    override init(frame: CGRect) {
        super.init(frame: frame)
        displayLink = CADisplayLink(target: self, selector: #selector(FPSLabel.handleDisplayLink(_:)))
        displayLink.add(to: RunLoop.main, forMode: .common)
        self.font = UIFont.systemFont(ofSize: 14)
        self.backgroundColor = UIColor(red: 60.0 / 255.0, green: 145.0 / 255.0, blue: 82.0 / 255.0, alpha: 1.0)
        self.textColor = UIColor.white
        self.textAlignment = .center
    }
    @objc func handleDisplayLink(_ sender:CADisplayLink){
        guard lastTimeStamp != -1.0 else {
            lastTimeStamp = displayLink.timestamp
            return
        }
        countPerFrame += 1
        let interval = displayLink.timestamp - lastTimeStamp
        guard interval >= 1.0 else {
            return
        }
        let fps = Int(round(countPerFrame / interval))
        self.text = "\(fps)"
        countPerFrame = 0
        lastTimeStamp = displayLink.timestamp
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        displayLink.remove(from: RunLoop.main, forMode: .common)
    }
}
