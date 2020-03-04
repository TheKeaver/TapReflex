//
//  MainMenuViewController.swift
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

class MainMenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var diffcultyTextField: UITextField!
    
    
    /// TODO: Make this dynamic to the game logic.
    /// Shouldn't be hard coded, some how retrieve fromt the game.
    let difficultyChoices = ["easy", "medium", "hard"]
    var choosenDifficulty = "easy"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDifficultyPicker()
        createToolBar()
        // Do any additional setup after loading the view.
    }
    

    
    
    ///Creates UIPicker
    func createDifficultyPicker() {
        let difficultyPicker = UIPickerView()

        difficultyPicker.delegate = self
        diffcultyTextField.inputView = difficultyPicker
    }
    
    
    
    
    /// Creates UI tool bar so that when user is done choosing,
    /// they are able to press the "Done" button
    func createToolBar() {
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard) )

        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        diffcultyTextField.inputAccessoryView = toolBar
    }
    
    
    
    
    
    /// Dismisses the keyboard view
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    
    // UIPicker view settings
    // Sets the number of rows, title for row, returning string when selecting a row
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        return difficultyChoices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficultyChoices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choosenDifficulty = difficultyChoices[row]
        diffcultyTextField.text = choosenDifficulty
    }
    
    
    
    
    
    /// This prepares the segue information (game difficulty) to pass on to
    /// the game logic.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameScreenVC: GameScreenViewController = (segue.destination as? GameScreenViewController)!
        gameScreenVC.passedDifficulty = choosenDifficulty
    }
    

}
