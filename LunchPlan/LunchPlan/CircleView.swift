//
//  Rainbow.swift
//  RainbowDemo
//
//  Created by Simon Ng on 29/3/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
class CircleView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor(red: (37.0/255.0), green: (252.0/255), blue: (244.0/255.0), alpha: 1.0)
    @IBInspectable var innerCircleRadius:CGFloat = 80

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func drawRect(rect: CGRect) {
        // Add ARCs
        self.addCirle(innerCircleRadius, color: self.firstColor)
    }
    
    func addCirle(arcRadius: CGFloat, color: UIColor) {
        let X = CGRectGetMidX(self.bounds)
        let Y = CGRectGetMidY(self.bounds)
        
        // Middle Cap
        let pathMiddle = UIBezierPath(ovalInRect: CGRectMake(X - (arcRadius/2), (Y - (arcRadius/2)), arcRadius, arcRadius)).CGPath
        let fillColor = color.colorWithAlphaComponent(0.4)
        self.addOval(0.0, path: pathMiddle, strokeStart: 0, strokeEnd: 1.0, strokeColor: UIColor.blackColor(), fillColor: fillColor, shadowRadius: 5.0, shadowOpacity: 0.5, shadowOffsset: CGSizeZero)
    }

    func addOval(lineWidth: CGFloat, path: CGPathRef, strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, fillColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffsset: CGSize) {
        
        let arc = CAShapeLayer()
        arc.lineWidth = lineWidth
        arc.path = path
        arc.strokeStart = strokeStart
        arc.strokeEnd = strokeEnd
        arc.strokeColor = strokeColor.CGColor
        arc.lineWidth = 2;
        arc.fillColor = fillColor.CGColor
        arc.shadowColor = UIColor.blackColor().CGColor
        arc.shadowRadius = shadowRadius
        arc.shadowOpacity = shadowOpacity
        arc.shadowOffset = shadowOffsset
        layer.addSublayer(arc)
    }
}