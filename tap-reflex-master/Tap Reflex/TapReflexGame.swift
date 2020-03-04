//
//  TapReflexGame.swift
//  Tap Reflex
//
//  Created by CSCI Student on 1/24/19.
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

import Foundation

class TapReflexGame
{
    private(set) var lives = 3
    private(set) var difficulty = "medium" // Default difficulty if none selected
    private(set) var score = 0
    private(set) var isGameOver = false
    private(set) var buttons = [TapButton]()

    var defaultTimer: Int {
        get {
            switch difficulty {
            case "easy": return 4 // There was no similar "5" image :]
            case "medium": return 4
            default: return 3 // functions as "hard" difficulty
            }
        }
    }
    
    /// number of buttons is computed as value
    /// is determined by the user during execution
    var numButtons: Int {
        get {
            switch difficulty {
            case "easy": return 12
            case "medium": return 24
            default: return 48 // functions as "hard" difficulty
            }
        }
    }
    
    
    /// Takes the difficulty selected by the user on the main screen
    ///
    /// - Parameter difficulty: Passed in indirectly from the MainMenu selection
    init(difficulty: String) {
        self.difficulty = difficulty
        for _ in 0..<numButtons {
            buttons.append(TapButton())
        }
    }
    
    
    /// Choose button called from GameScreenViewController.
    /// Sets inactive of currently active buttons and increases score
    ///
    /// - Parameter index: Index of button extracted from index of UIViews
    func chooseButton(indexOfButtonView index: Int) {
        if buttons[index].isActive == true {
            score += 1
            buttons[index].isActive = false
        }
    }
    
    
    /// Called from GameScreenViewController, updates countdown timers of all
    /// buttons currently active. Uses 'counter' variable to differentiate between
    /// buttons in 10 parts. Every 10 iterations each button should be updated once.
    ///
    /// - Parameter counter: A 0-9 value passed from VC, assigns which active buttons
    ///                      are to be activated
    func updateCountdowns(_ counter: Int) {
        for index in 0 ..< numButtons {
            if buttons[index].isActive == true && buttons[index].count == counter {
                let result = buttons[index].updateCountdown()
                if result == false {
                    lives -= 1
                    if lives <= 0 {
                        isGameOver = true
                    }
                }
            }
        }
    }
    
    
    /// Called from VC, sets 'isActive' of random button using Int extension
    ///
    /// - Parameter counter: Initialize the activation of a button with a 0-9
    ///   number. Used in updateCountdowns to determine what buttons must be updated.
    func activateButton(_ counter: Int) {
        var random = numButtons.arc4random
        while buttons[random].isActive == true {
            random = numButtons.arc4random
        }
        buttons[random].timeRemaining = defaultTimer
        buttons[random].isActive = true
        buttons[random].count = counter
    }
    
}

extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}
