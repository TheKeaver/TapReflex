//
//  GameOverViewController.swift
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

class GameOverViewController: UIViewController {

    
    @IBOutlet weak var FinalScoreLabel: UILabel!
    @IBOutlet weak var RestartGameButton: UIButton!
    @IBOutlet weak var MainMenuButton: UIButton!
    
    
    
    
    var finalScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainMenuButton.layer.cornerRadius = 9
        RestartGameButton.layer.cornerRadius = 9
        FinalScoreLabel.text = "Final Score: \(finalScore)"
        // Do any additional setup after loading the view.
    }
    
    
    /// Dismissed Current Screen to get to the Game Screen
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.viewDidLoad()
    }
    
    
    /// Dismissed Every Screen to until Main Menu Screen
    @IBAction func mainMenuButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
        
    }
    
    
    
    
    
}
