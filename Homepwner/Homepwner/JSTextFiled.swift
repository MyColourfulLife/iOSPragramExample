//
//  JSTextFiled.swift
//  Homepwner
//
//  Created by 黄家树 on 2018/3/25.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class JSTextFiled: UITextField {
    
    
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        layer.borderWidth = 1
        layer.borderColor = UIColor.green.cgColor
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        layer.borderColor = UIColor.clear.cgColor
        
        return true
        
    }
    
}
