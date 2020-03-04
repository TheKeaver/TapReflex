//
//  ViewController.swift
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

import UIKit

class GameScreenViewController: UIViewController {

    var passedDifficulty: String?
    var timer: Timer?
    lazy var game = TapReflexGame( difficulty: passedDifficulty!)
    
    // To test gradual game speed increase uncomment the '* 10' from below
    lazy var activateNewButtonTimer = (game.defaultTimer) // * 10
    var timerInterval = 0.1
    var counter = 0
    var tapButtonViews = [TapButtonView]()
    var isTimerPaused = false      // flag for timer that is paused
    
    
    // Game Screen Compoenents
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var PauseButton: UIButton!
    @IBOutlet var LivesLabel: [UILabel]!
    
    
    //Pause Screen Components
    @IBOutlet weak var pauseMenuView: PauseMenuView!
    @IBOutlet weak var RestartGameButton: UIButton!
    @IBOutlet weak var MainMenuButton: UIButton!
    @IBOutlet weak var PauseButtonsStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RestartGameButton.alpha = 1
        MainMenuButton.alpha = 1
        RestartGameButton.layer.cornerRadius = 10
        MainMenuButton.layer.cornerRadius = 10
        ScoreLabel.clipsToBounds = true
        ScoreLabel.layer.cornerRadius = 10
        PauseButton.layer.cornerRadius = 10
        restartGameAndViews()
    }
    
    
    
    
    
    
    
    
    
    /// When the restart button is pressed, then resets all the properties to the game
    /// logic, including the timer and also updating the views to game.
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        timer?.invalidate()
        restartGameAndViews()
        isTimerPaused = false
        pauseMenuView.isHidden = true
        PauseButtonsStack.isHidden = true
        PauseButton.setTitle("||", for: .normal)
        PauseButton.backgroundColor = #colorLiteral(red: 0.4322627783, green: 0.7128716111, blue: 0.8052893281, alpha: 1)
    }
    
    
    
    /// Main Menu action method that when pressed, it takes user back to the
    /// main menu by dismissing the screen
   @IBAction func mainMenuButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 
    
    
    
    /// When the pause button is pressed, the timer freezes, and the pause menu
    /// is revealed. Otherwise to unpause, the timer recreated to start back up.
    /// During this time pause button components are updated accordingly.
    /// - Parameter sender: <#sender description#>
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        isTimerPaused = !isTimerPaused
        
        // If time is paused, then it will pause timer, and run timer to resume
        if isTimerPaused {
            PauseButtonsStack.isHidden = false
            PauseButton.setTitle("►", for: .normal)
            PauseButton.backgroundColor = #colorLiteral(red: 0.9995597005, green: 0, blue: 0, alpha: 1)
            timer?.invalidate()
        } else {
            PauseButtonsStack.isHidden = true
            PauseButton.setTitle("||", for: .normal)
            PauseButton.backgroundColor = #colorLiteral(red: 0.4322627783, green: 0.7128716111, blue: 0.8052893281, alpha: 1)
            runTimer()
        }
        
        // Hides/reveals pause menu
        pauseMenuView.isHidden = !pauseMenuView.isHidden
    }
    
    
    
    
    /// Update the views, when the game board view changes
    @IBOutlet weak var gameBoardView: GameBoardView! {
        didSet {
            initialization()
            updateViewFromModel()
        }
    }
    
    
    
    
    /// Adds UI gesture recognizer, goes through each game number buttons
    /// through each view and adds gesture recognizer.
    private func initialization() {
        for _ in 0 ..< game.numButtons {
            let tapView = TapButtonView()
            let tap = UITapGestureRecognizer(target: self, action: #selector(selectAButton(byHandlingGestureRecognizedBy:)))
            
            tapView.addGestureRecognizer(tap)
            tapButtonViews.append(tapView)
        }
        
        tapButtonViews.forEach( { gameBoardView.addSubview($0) } )
    }
    
    
    
    
    
    /// Updates the vies from the Tap Reflex game model
    private func updateViewFromModel() {
        // check if game is over to perform segue to Game Over Screen
        if game.isGameOver {
            timer?.invalidate()
            performSegue(withIdentifier: "GameOverSegue", sender: self)
        }
        
        ScoreLabel.text = "\(game.score)"           //Updates Score label
        updateNumLivesLeft(livesLeft: game.lives)   //Updates Number of lives
        
        // Updating views with the game buttons
        for index in 0 ..< game.numButtons {
            let tapView = tapButtonViews[index]
            tapView.isActive = game.buttons[index].isActive
            tapView.timeRemaining = game.buttons[index].timeRemaining
        }
    }
    
    
    
    
    /// This activates a new button and controls the frequency of
    /// a button being actictivate. Once button is activated and updates views
    @objc func activateButtonAfterTimer() {
        //print(activateNewButtonTimer)
        if counter % activateNewButtonTimer ==  0 {
            if activateNewButtonTimer > 5 {
                activateNewButtonTimer -= 1
            }
            //print("Activated: Counter = \(counter)")
            game.activateButton(counter % 10)
        }
        counter += 1
        game.updateCountdowns(counter % 10)
        updateViewFromModel()
    }
    
    
    
    
    
    /// This adds a gesture recognizer to each view. When button is selected, it gets index
    /// from the view to communicate to the game logic choosen and view/button properties to
    /// active or non active. Then updates views.e
    /// - Parameter recognizer: <#recognizer description#>
    @objc func selectAButton(byHandlingGestureRecognizedBy recognizer: UITapGestureRecognizer) {
        // Downcast "recognizer" in order to get cardView's data for comparison later
        //print("Button Clicked")
        if let tapView = recognizer.view as? TapButtonView {
            // Once tap has complete, call helper method to either deselect the card
            // or to add it to the currently selected cards array
            switch recognizer.state {
            case .ended:
                if tapView.isActive == true { //  && tapView.timeRemaining > 0
                    tapView.isActive = false
                    let indexOfButtonView = tapButtonViews.firstIndex(of: tapView)
                    game.chooseButton(indexOfButtonView: indexOfButtonView!)
                }
            default: break
            }
        }
        updateViewFromModel()
    }
    
    
    


    // Simple helper functions for the VC
    
    func restartGameAndViews() {
        game = TapReflexGame(difficulty: passedDifficulty!)
        revealLivesLabels()
        runTimer()
    }
    
    func updateNumLivesLeft( livesLeft: Int ) {
        for i in 0..<(LivesLabel.count - livesLeft) {
            LivesLabel[i].isHidden = true
        }
    }

    func revealLivesLabels() {
        LivesLabel.forEach({ $0.isHidden = false; print("hidden = false") })
    }
    
    
    /// Restarts the timer.
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(timerInterval), target: self, selector: #selector(activateButtonAfterTimer), userInfo: nil, repeats: true)
    }
    
    
    
    
    
    /// Prepares Segue to the game Over Screen and prepares game score information
    /// to display as final score when game ends. Creates a GameOverViewController object
    /// and sets the properties from that object before segue
    /// - Parameters:
    ///   - segue: <#segue description#>
    ///   - sender: <#sender description#>
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameOverVC: GameOverViewController = segue.destination as! GameOverViewController
        gameOverVC.finalScore = game.score
    }
}

