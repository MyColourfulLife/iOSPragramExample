//
//  ViewController.swift
//  Quiz
//
//  Created by 黄家树 on 2018/3/15.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var anserLabel: UILabel!
    let questions:[String] = ["From what is cognac made?",
                              "What is 7+7 ?",
                              "What is the capital of Vermont ?"]
    let ansers:[String] = ["Grapes",
                           "14",
                           "Montpelier"]
    var currentQuestionIndex:Int = 0
    
    
    @IBAction func showNextQuestion(sender:AnyObject) {
        currentQuestionIndex = currentQuestionIndex + 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let qustion:String = questions[currentQuestionIndex]
        questionLabel.text = qustion
        anserLabel.text = "???";
    }
    
    @IBAction func showAnser(sender:AnyObject) {
        let answer:String = ansers[currentQuestionIndex]
        anserLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]
    }
}


