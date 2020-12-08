//
//  UITabBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/7.
//

import UIKit

extension UIBarButtonItem{
    class func creatBarButtonItem(imageName : String, hilightImageName : String, size : CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hilightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
    convenience init(imageName : String, hilightImageName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hilightImageName != "" {
            btn.setImage(UIImage(named: hilightImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView : btn)
    }
}


