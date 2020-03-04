//
//  TapButtonView.swift
//  Tap Reflex
//
//  Created by CSCI Student on 1/25/19.
//  Copyright © 2019 CSCI Student. All rights reserved.
//
/*
 Name: Joshua Moran and Keith Petitt
 Date: 1/28/18
 Term: J-Term 2019
 Course: CSCI 387
 Assignment: Final Project - Tap Reflex
 Sources Consulted: Stack Overflow
 Notes to Grader:
 In order to recreate a truly reaction based game it is impossible to simultaneously
 implement gradually increasing game speed simultaneously given our implementation.
 */

import UIKit
import GameplayKit

@IBDesignable class TapButtonView: UIView {
    
    @IBInspectable var imageFile: String = "countdown3" {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    @IBInspectable var timeRemaining: Int = 4 {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    @IBInspectable var powerUp = "countdown" {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    @IBInspectable var isActive = false {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    var faceCardScale: CGFloat = SizeRatio.faceCardImageSizeToBoundsSize {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        if isActive {
            switch powerUp {
            case "countdown":
                // Each countdown image is titled based on how many seconds remaining
                imageFile = powerUp + String(timeRemaining)
                UIColor.red.setFill()
            case "freeze":
                // never implemented a freeze ability, however we can in the future
                imageFile = powerUp
                UIColor.blue.setFill()
            default:
                // defualt case never used, every powerUp is "countdown"
                imageFile = powerUp
                UIColor.white.setFill()
            }
            roundedRect.fill()
            if let faceCardImage = UIImage(named: imageFile,  in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
                faceCardImage.draw(in: bounds.zoom(by: faceCardScale))
            } else {
                print("Error in drawing image: \(imageFile)")
            }
        } else { // Button isActive: False
            UIColor.black.setFill()
            roundedRect.fill()
        }
    }
}

/// Various extensions used for aspect ration and zoom accuracy
extension TapButtonView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
}

// extends CGRect for drawing
extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth)/2, dy: (height - newHeight)/2)
    }
}


extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
