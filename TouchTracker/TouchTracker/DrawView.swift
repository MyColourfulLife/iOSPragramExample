//
//  DrawView.swift
//  TouchTracker
//
//  Created by 黄家树 on 2018/3/29.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var currentLine = [NSValue:Line]()
    var finishedLines = [Line]()
    
    
    @IBInspectable var finishedLineColor:UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var currentLineColor:UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineThickness:CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    func strokeLine(line:Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        // draw finished line
        finishedLineColor.setStroke()
        for line in finishedLines {
            strokeLine(line: line)
        }
        // draw current line
        currentLineColor.setStroke()
        for (_,line) in currentLine {
            strokeLine(line: line)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            let key = NSValue.init(nonretainedObject: touch)
            currentLine[key]=newLine
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let key = NSValue.init(nonretainedObject: touch)
            currentLine[key]?.end = touch.location(in: self)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let key = NSValue.init(nonretainedObject: touch)
            if var line = currentLine[key] {
                let location = touch.location(in: self)
                line.end = location
                finishedLines.append(line)
                currentLine.removeValue(forKey: key)
            }
        }

        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentLine.removeAll()
        setNeedsDisplay()
    }
    
}
