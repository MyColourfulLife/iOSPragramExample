//
//  ConversionViewController.swift
//  WorldTroter
//
//  Created by 黄家树 on 2018/3/18.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit
import MapKit

class ConversionViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var celsiusLabel:UILabel!
    @IBOutlet var textField:UITextField!
    
    var randomColor:UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController load it's view.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = randomColor
    }
    
    
    let numberFormatter:NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    var fahrenHeitValues:Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue:Double? {
        if let value = fahrenHeitValues {
            return (value - 32 ) * (5/9)
        } else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let value:Double = celsiusValue {
            let valuen = NSNumber(value:value)
            celsiusLabel.text = numberFormatter.string(from:valuen)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    @IBAction func didmissKeyborad(sender:AnyObject) {
        textField.resignFirstResponder()
    }
    
    @IBAction func fahrenHeitFieldEditingChanged(textField:UITextField) {
        
        if let text = textField.text, let value = Double(text) {
            fahrenHeitValues = value
        } else {
            fahrenHeitValues = nil
        }
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSepartor = textField.text?.range(of: ".")
        let replacementTextHasDecimalSepartor = string.range(of: ".")
        
        let set = NSCharacterSet(charactersIn: "0123456789.");
        
        for i in 0 ..< string.lengthOfBytes(using: .utf8) {
            let char = (string as NSString).character(at: i)
            if !set.characterIsMember(char) {
                return false;
            }
        }
        
        return !(existingTextHasDecimalSepartor != nil && replacementTextHasDecimalSepartor != nil)
    }

    
    
}
