//
//  ViewController.swift
//  TicTacToe
//
//  Created by Eric Chang on 9/20/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class GameBoardController: UIViewController {
  
  
  // Properties
  // Properties
  
  var isPlayerOne = true
  var ticTacToeState = [[State]]()
  
  enum State {
    case Empty
    case PlayerOne
    case PlayerTwo
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupGameBoard()
  }
  
  
  /**
   * Setup Game:
   *  Call setup func - playable square - setup reset button - buttons to press
   */
  
  func setupGameBoard() {
    for row in 0..<3 {
      for col in 0..<3 {
        constructButtonAt(row: row, col: col)
      }
    }
    setupResetButton()
    setupGameState()
  }
  
  func setupGameState() {
    for _ in 0..<3 {
      let row = Array(repeating: State.Empty, count: 3)
      ticTacToeState.append(row)
    }
    /**
     * Makes grid:
     *  [Empty, Empty, Empty], [Empty, Empty, Empty], [Empty, Empty, Empty]
     */
  }
  
  
  func setupResetButton() {
    let frame = CGRect(x: 300, y: 500, width: 80, height: 55)
    let button = UIButton(frame: frame)
    
    button.backgroundColor = UIColor(red: 0.6314, green: 0.6196, blue: 0.8471, alpha: 1.0)
    button.setTitle("Restart", for: .normal)
    button.tag = 99
    button.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
    view.addSubview(button)
  }
  
  func constructButtonAt(row: Int, col: Int) {
    let xValue = (col * 90) + 50
    let yValue = (row * 90) + 120
    
    let frame = CGRect(x: xValue, y: yValue, width: 80, height: 80)
    let button = UIButton(frame: frame)
    button.backgroundColor = UIColor(red: 0.7294, green: 0.8706, blue: 1, alpha: 1.0)
    let title = "\(row), \(col)"
    button.titleLabel!.font =  UIFont(name: "Arial", size: 0)
    button.setTitle(title, for: .normal)
    button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
    view.addSubview(button)
  }
  
  
  /**
   * Actions:
   *  Button tapped - Reset tapped - Winner decider
   */
  
  func handleButtonTapped(button: UIButton) {
    button.isEnabled = false
    guard let title = button.currentTitle else { return }
    let indexValue = convertStringToTuple(title: title)
    if isPlayerOne {
      isPlayerOne = false
      ticTacToeState[indexValue.0][indexValue.1] = .PlayerOne
      button.backgroundColor = UIColor(red: 0.6392, green: 1, blue: 0.6745, alpha: 1.0)
      button.setTitle("o3o", for: .normal)
      button.titleLabel!.font = UIFont(name: "Arial", size: 30)
    } else {
      isPlayerOne = true
      ticTacToeState[indexValue.0][indexValue.1] = .PlayerTwo
      button.backgroundColor = UIColor(red: 1, green: 0.7294, blue: 0.7294, alpha: 1.0)
      button.setTitle(";~;", for: .normal)
      button.titleLabel!.font = UIFont(name: "Arial", size: 30)
    }
    checkWinner()
  }
  
  func handleReset(button: UIButton) {
    for v in view.subviews {
      v.removeFromSuperview()
    }
    isPlayerOne = true
    ticTacToeState = [[State]]()
    setupGameBoard()
  }
  
  func convertStringToTuple(title: String) -> (Int, Int) {
    let numbers = title.components(separatedBy: ", ")
    var tuple: (Int, Int)
    let first = Int(numbers[0])!
    let second = Int(numbers[1])!
    tuple = (first, second)
    return tuple
  }
  
  // Win Conditions
  // Win Conditions
  
  func checkWinner() {
    checkAllRowWinner()
    checkAllColWinner()
    checkAllDiagonalWinner()
  }
  
  func playerWins() {
    for v in view.subviews {
      if let button = v as? UIButton {
        if button.tag != 99 {
          button.isEnabled = false
        }
      }
    }
    return
  }
  
  let playerOne = Array(repeating: State.PlayerOne, count: 3)
  let playerTwo = Array(repeating: State.PlayerTwo, count: 3)
  
  func checkAllRowWinner() {
    for row in ticTacToeState {
      if row ==  playerOne {
        playerWins()
      }
      else if row == playerTwo {
        playerWins()
      }
    }
  }
  
  func checkAllColWinner() {
    var colCheck = [State]()
    var i = 0
    while i < 3 {
      for row in ticTacToeState {
        colCheck.append(row[i])
      }
      if colCheck == playerOne || colCheck == playerTwo {
        playerWins()
      }
      colCheck = []
      i += 1
    }
  }
  
  func checkAllDiagonalWinner() {
    var diagCheck = [State]()
    var crossCheck = [State]()
    var i = 0
    var j = 2
    for row in ticTacToeState {
      diagCheck.append(row[i])
      crossCheck.append(row[j])
      i += 1
      j -= 1
    }
    if diagCheck == playerOne || diagCheck == playerTwo {
      playerWins()
    }
    if crossCheck == playerOne || diagCheck == playerTwo {
      playerWins()
    }
  }
  
}

