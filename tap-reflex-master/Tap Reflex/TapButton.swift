//
//  TapButton.swift
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

/// Enum For PowerUps (normal or freeze powerup)
/// Normal meaning that it has no power up
/// Not implemented in this program
enum PowerUp: String, CustomStringConvertible {
    case normal = "countdown", freeze = "freeze"
    
    var description: String {
        return self.rawValue
    }
    
}

struct TapButton: CustomStringConvertible{

    var timeRemaining = 5
    var powerUp: PowerUp
    var isActive: Bool
    var count: Int = 0
    
    /// Intended for use in improved versions of our program
    var description: String {
        return "Button isActive: \(isActive)"
    }
    
    /// init hard codes powerUp given that randomness was not implemented
    init() {
        self.powerUp = .normal
        self.isActive = false
    }
    
    
    /// Called from TapReflexGame to update local timeRemaining var
    ///
    /// - Returns: Return false if countdown reaches 0
    mutating func updateCountdown() -> Bool {
        timeRemaining -= 1
        if timeRemaining <= 0 {
            isActive = false
        }
        return isActive
    }
}
