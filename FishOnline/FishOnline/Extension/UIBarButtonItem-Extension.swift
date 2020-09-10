//
//  UIBarButtonItem-Extension.swift
//  FishOnline
//
//  Created by ZPG's Mac on 10/9/20.
//  Copyright © 2020 Code With ZPG. All rights reserved.
//

import UIKit
extension UIBarButtonItem{

    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero)  {

        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }

        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView : btn)
    }
    
}
