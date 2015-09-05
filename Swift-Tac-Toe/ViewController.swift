//
//  ViewController.swift
//  Swift-Tac-Toe
//
//  Created by MacBook Pro on 9/2/15.
//  Copyright © 2015 LLabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var rstBtn: UIButton!

    @IBOutlet var ticTacImg1: UIImageView!
    @IBOutlet var ticTacImg2: UIImageView!
    @IBOutlet var ticTacImg3: UIImageView!
    @IBOutlet var ticTacImg4: UIImageView!
    @IBOutlet var ticTacImg5: UIImageView!
    @IBOutlet var ticTacImg6: UIImageView!
    @IBOutlet var ticTacImg7: UIImageView!
    @IBOutlet var ticTacImg8: UIImageView!
    @IBOutlet var ticTacImg9: UIImageView!
    
    @IBOutlet var ticTacBtn1: UIButton!
    @IBOutlet var ticTacBtn2: UIButton!
    @IBOutlet var ticTacBtn3: UIButton!
    @IBOutlet var ticTacBtn4: UIButton!
    @IBOutlet var ticTacBtn5: UIButton!
    @IBOutlet var ticTacBtn6: UIButton!
    @IBOutlet var ticTacBtn7: UIButton!
    @IBOutlet var ticTacBtn8: UIButton!
    @IBOutlet var ticTacBtn9: UIButton!
    
    
    @IBOutlet var userMessage: UILabel!
    
    var plays = Dictionary<Int, Int>()
    var done = false
    var aiDeciding = false
    
    @IBAction func UIButtonClicked(sender:UIButton){
        if plays[sender.tag] == nil && !aiDeciding && !done{
        
            setImageForSpot(sender.tag, player:1)
            
            if (!CheckforWin())
            {
                aiMove()
            
                CheckforWin()
            }
        }
    }
    
    @IBAction func UIButtonReset(sender:UIButton){
            userMessage.hidden = true
            reset()
    }
    
    func aiMove () {
        aiDeciding = true
        
        
        // Check for the win
        if let result = rowCheck(value: 0) {
            var whereToPlayResults = whereToPlay(result.location, pattern: result.pattern)
            if !isOccupied(whereToPlayResults){
                setImageForSpot(whereToPlayResults, player: 0)
                aiDeciding = false
                CheckforWin()
                return
            }
        }
        
        // Check for block
        if let result = rowCheck(value: 1) {
            var whereToPlayResults = whereToPlay(result.location, pattern: result.pattern)
            if !isOccupied(whereToPlayResults){
                setImageForSpot(whereToPlayResults, player: 0)
                aiDeciding = false
                CheckforWin()
                return
            }
        }
        
        // Check for the center
        if(!isOccupied(5)){
            setImageForSpot(5, player:0)
            aiDeciding = false
            CheckforWin()
            return
        }
        
        func firstAvailable(isCorner: Bool) -> Int? {
            var spots = isCorner ? [1,3,7,9] : [2,4,6,8]
            for spot in spots {
                if !isOccupied(spot){
                    return spot
                }
            }
            return 0
        }
        
        // Check for corners
        if let cornerAvailable = firstAvailable(true){
            setImageForSpot(cornerAvailable, player: 0)
            aiDeciding = false
            CheckforWin()
            return
            
        }
        
        // Check for sides
        if let sideAvailable = firstAvailable(false){
            setImageForSpot(sideAvailable, player: 0)
            aiDeciding = false
            CheckforWin()
            return
        }
        
        userMessage.hidden = false
        userMessage.text = "Looks like it was a tie"
        
        reset()
        
        aiDeciding = false
    }
    
    func isOccupied(spot:Int) -> Bool {
        return Bool(plays[spot] != nil)
    }
    
    func whereToPlay(location:String, pattern:String) -> Int {
        
        var leftPattern = "011"
        var rightPattern = "110"
        var middlePattern = "101"
        
        switch location {
            
        case "topRow":
                if pattern == "011" {
                    return 1
                }else if pattern == "110" {
                    return 3
                }else if pattern == "101" {
                    return 2
                }
        case "middleRow":
            if pattern == "011" {
                return 4
            }else if pattern == "110" {
                return 6
            }else if pattern == "101" {
                return 5
            }
        case "bottomRow":
                if pattern == "011" {
                    return 7
                }else if pattern == "110" {
                    return 9
                }else if pattern == "101" {
                    return 8
            }
        case "leftColumn":
            if pattern == "011" {
                return 1
            }else if pattern == "110" {
                return 7
            }else if pattern == "101" {
                return 4
            }
        case "rightColumn":
                if pattern == "011" {
                    return 3
                }else if pattern == "110" {
                    return 9
                }else if pattern == "101" {
                    return 6
            }
        case "middleColumn":
            if pattern == "011" {
                return 2
            }else if pattern == "110" {
                return 8
            }else if pattern == "101" {
                return 5
            }
        case "leftRightDiag":
            if pattern == "011" {
                return 1
            }else if pattern == "110" {
                return 9
            }else if pattern == "101" {
                return 5
            }
        case "rightLeftDiag":
            if pattern == "011" {
                return 3
            }else if pattern == "110" {
                return 5
            }else if pattern == "101" {
                return 7
            }
        default: return 4
        }
        
        return 4
    }
    
    // Checking for the possible combinations
    func topRow(value value:Int) -> (location:String, pattern:String) {
        return ("topRow", buildRowString(value, spots: [1,2,3]))
    }
    func middleRow(value value:Int) -> (location:String, pattern:String) {
        return ("middleRow", buildRowString(value, spots: [4,5,6]))
    }
    func bottomRow(value value:Int) -> (location:String, pattern:String) {
        return ("bottomRow", buildRowString(value, spots: [7,8,9]))
    }
    func leftColumn(value value:Int) -> (location:String, pattern:String) {
        return ("leftColumn", buildRowString(value, spots: [1,4,7]))
    }
    func rightColumn(value value:Int) -> (location:String, pattern:String) {
        return ("rightColumn", buildRowString(value, spots: [3,6,9]))
    }
    func middleColumn(value value:Int) -> (location:String, pattern:String) {
        return ("middleColumn", buildRowString(value, spots: [2,5,8]))
    }
    func leftRightDiag(value value:Int) -> (location:String, pattern:String) {
        return ("lefRightDiag", buildRowString(value, spots: [1,5,9]))
    }
    func rightLeftDiag(value value:Int) -> (location:String, pattern:String) {
        return ("rightLeftDiag", buildRowString(value, spots: [3,5,7]))
    }
    
    // Looping through the values sent and create string
    func buildRowString (value:Int, spots:[Int]) -> String {
        var result = ""
        
        for spot in spots {
            if (plays[spot] == value){
                result += "1"
            }
            else{
                result += "0"
            }
        }
        return result
    }
    
    func rowCheck(value value:Int) -> (location:String, pattern:String)? {
        var combos = ["110","101","011"]
        var possibleWins = [topRow, middleRow, bottomRow, leftColumn, middleColumn, rightColumn, leftRightDiag, rightLeftDiag]
        for algorithm in possibleWins {
            var results = algorithm(value: value)
            
            if (combos.indexOf(results.pattern) != nil){
               
                return results
            }

        }
        
        return nil
    }
    
    func setImageForSpot(spot:Int,player:Int){
        let playerMark = player == 1 ? "x" : "o"
        plays[spot] = player
        switch spot {
        case 1:
            ticTacImg1.image = UIImage(named: playerMark)
        case 2:
            ticTacImg2.image = UIImage(named: playerMark)
        case 3:
            ticTacImg3.image = UIImage(named: playerMark)
        case 4:
            ticTacImg4.image = UIImage(named: playerMark)
        case 5:
            ticTacImg5.image = UIImage(named: playerMark)
        case 6:
            ticTacImg6.image = UIImage(named: playerMark)
        case 7:
            ticTacImg7.image = UIImage(named: playerMark)
        case 8:
            ticTacImg8.image = UIImage(named: playerMark)
        case 9:
            ticTacImg9.image = UIImage(named: playerMark)
        default:
            ticTacImg5.image = UIImage(named: playerMark)
        }
    }
    
    
    func reset(){
        ticTacImg1.image = nil
        ticTacImg2.image = nil
        ticTacImg3.image = nil
        ticTacImg4.image = nil
        ticTacImg5.image = nil
        ticTacImg6.image = nil
        ticTacImg7.image = nil
        ticTacImg8.image = nil
        ticTacImg9.image = nil
        
        plays = [:]
        
        userMessage.hidden = true
        rstBtn.hidden = true
        done = false
    }
    
    func CheckforWin() -> Bool {
        var whoWon = ["I":0,"you":1]
        
        for (key, value) in whoWon {
            if((plays[1] == value && plays[2] == value && plays[3] == value) ||
               (plays[4] == value && plays[5] == value && plays[6] == value) ||
                (plays[7] == value && plays[8] == value && plays[9] == value) ||
                (plays[1] == value && plays[4] == value && plays[7] == value) ||
                (plays[2] == value && plays[5] == value && plays[8] == value) ||
                (plays[3] == value && plays[6] == value && plays[9] == value) ||
                (plays[1] == value && plays[5] == value && plays[9] == value) ||
                (plays[3] == value && plays[5] == value && plays[7] == value))
            {
                userMessage.text = "Game over \(key) won!"
                userMessage.hidden = false
                rstBtn.hidden = false
                done = true
                
                return true
            }
        }
        
        if (!done && plays.count == 9)
        {
            done = true
            userMessage.text = "CATS"
            userMessage.hidden = false
            rstBtn.hidden = false
            
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    }
