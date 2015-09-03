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
    @IBOutlet var ticTacBtn8: UIButton! = nil
    @IBOutlet var ticTacBtn9: UIButton! = nil
    
    
    @IBOutlet var userMessage: UILabel! = nil
    
    var plays = Dictionary<Int, Int>()
    var done = false
    var aiDeciding = false
    
    @IBAction func UIButtonClicked(sender:UIButton){
        if plays[sender.tag] == nil && !aiDeciding && !done{
        
            setImageForSpot(sender.tag, player:1)
            
            CheckforWin()
        }
    }
    
    @IBAction func UIButtonReset(sender:UIButton){
            userMessage.hidden = true
            reset()
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
    
    func CheckforWin(){
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
            }
        }
        
        if (!done && plays.count == 9)
        {
            done = true
            userMessage.text = "CATS"
            userMessage.hidden = false
            rstBtn.hidden = false
        }
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
