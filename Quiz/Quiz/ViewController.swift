//
//  ViewController.swift
//  Quiz
//
//  Created by 黄家树 on 2018/3/15.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var currentQuestionLable:UILabel!
    @IBOutlet var nextQuestionLabel:UILabel!
    @IBOutlet var currentQuestionLableCenterXConstraint:NSLayoutConstraint!
    @IBOutlet var nextQuestionLabelCenterXConstraint:NSLayoutConstraint!
    
    
    @IBOutlet var anserLabel: UILabel!
    let questions:[String] = ["From what is cognac made?",
                              "What is 7+7 ?",
                              "What is the capital of Vermont ?"]
    let ansers:[String] = ["Grapes",
                           "14",
                           "Montpelier"]
    var currentQuestionIndex:Int = 0
    var currentQuestionCenterXConstraint:CGFloat!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // initial
        nextQuestionLabel.alpha = 0;
    }
    
    @IBAction func showNextQuestion(sender:AnyObject) {
        currentQuestionIndex = currentQuestionIndex + 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let qustion:String = questions[currentQuestionIndex]
        nextQuestionLabel.text = qustion
        anserLabel.text = "???"
        animateLabelTransition()
    }
    
    @IBAction func showAnser(sender:AnyObject) {
        let answer:String = ansers[currentQuestionIndex]
        anserLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLable.text = questions[currentQuestionIndex]
        currentQuestionCenterXConstraint = currentQuestionLableCenterXConstraint.constant;
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
        currentQuestionLableCenterXConstraint.constant = currentQuestionCenterXConstraint// 如果没有这一句，在连续点按下一题时，会出现看不到当前问题的label
    }
    
    func animateLabelTransition() {
        // 先让标签文字等布局好，再开始动画
        view.layoutIfNeeded()
        
        // 更改约束并不会立刻触发，需要手动调用 layoutifneeded 我们在动画里调用
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLableCenterXConstraint.constant = currentQuestionCenterXConstraint + screenWidth;
        
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [.curveLinear],
            animations: {
                self.nextQuestionLabel.alpha = 1
                self.currentQuestionLable.alpha = 0;
                self.view.layoutIfNeeded()
        },
            completion: {_ in
                // 交换位置
                swap(&self.currentQuestionLable, &self.nextQuestionLabel)
                swap(&self.currentQuestionLableCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                self.updateOffScreenLabel()
        })
    }
    
}


