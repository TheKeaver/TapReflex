//
//  GameBoardView.swift
//  Tap Reflex
//
//  Created by CSCI Student on 1/26/19.
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

class GameBoardView: UIView {

    override func layoutSubviews() {
        super .layoutSubviews()
        
        // Uses the Grid class to efficiently divide the screen for each card
        let setGrid = Grid(for: self.frame,
                           withNoOfFrames: self.subviews.count,
                           forIdeal: 1.0)
        
        for index in self.subviews.indices {
            if var frame = setGrid[index] {
                frame.size.width -= 5
                frame.size.height -= 5
                self.subviews[index].frame = frame
                self.subviews[index].clipsToBounds = true
                self.subviews[index].layer.cornerRadius = 6
                self.subviews[index].layer.borderWidth = 1
                self.subviews[index].layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
    }

}
