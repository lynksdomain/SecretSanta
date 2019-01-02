//
//  Scanline.swift
//  SecretSanta
//
//  Created by C4Q on 12/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit


struct Scanline {
    static func addScanline(to screen: UIView) {
        let scanLine: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: screen.frame.width, height: 2))
        scanLine.backgroundColor = UIColor.green.withAlphaComponent(0.4)
        scanLine.layer.shadowColor = UIColor.green.cgColor
        scanLine.layer.shadowRadius = 10
        scanLine.layer.shadowOpacity = 1
        scanLine.layer.shadowOffset = CGSize.zero
        scanLine.layer.masksToBounds = false
        scanLine.center = CGPoint(x: scanLine.center.x, y: 0)
        scanLine.isHidden = false
        screen.addSubview(scanLine)
        scanLine.glow()
        UIView.animate(withDuration: 7, delay: 0.0, options: [.repeat, .beginFromCurrentState, .curveLinear], animations: {() -> Void in
            scanLine.center = CGPoint(x: scanLine.center.x, y: screen.frame.size.height)
        }, completion: nil)
    }
}
