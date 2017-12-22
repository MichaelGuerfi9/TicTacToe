//
//  PlayViewController.swift
//  TicTacToe
//
//  Created by Michael Guerfi on 25/10/2017.
//  Copyright © 2017 Michael Guerfi. All rights reserved.
//

import UIKit
import SocketIO

class PlayViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {}
    }
    
//    1  2  3 6
//    4  5  6 15
//    7  8  9 24
//15  12 15 18 15

    var winner = ""
    func gamePlay() -> Void {
        let winPossibilities = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
        let buttonsNoughtInt = buttonsNought as! [Int]
        let buttonsCrossInt = buttonsCross as! [Int]
        var winNought = Array<Bool>()
        var winCross = Array<Bool>()
        winPossibilities.forEach{ index in
            index.forEach{ indexInt in
                if buttonsNoughtInt.contains(indexInt){
                    winNought.append(true)
                }
                if buttonsCrossInt.contains(indexInt){
                    winCross.append(true)
                }
            }
            if(winCross != [true,true,true]){
                winCross.removeAll()
            }else{
                winner="Cross"
                let lastKill = ["winner":"Cross","loser":"Nought"]
                if(UserDefaults.standard.array(forKey: "ScoreBoard") != nil){
                    var data  = UserDefaults.standard.array(forKey: "ScoreBoard") as! [[String:String]]
                    data.append(lastKill)
                    UserDefaults.standard.set(data, forKey: "ScoreBoard")
                }
                else {
                    UserDefaults.standard.set([lastKill], forKey: "ScoreBoard")
                }
                print(UserDefaults.standard.array(forKey: "ScoreBoard"))

                return
            }
            if(winNought != [true,true,true]){
                winNought.removeAll()
            }else{
                winner = "Nought"
                let lastKill = ["winner":"Nought","loser":"Cross"]
                if(UserDefaults.standard.array(forKey: "ScoreBoard") != nil){
                    var data  = UserDefaults.standard.array(forKey: "ScoreBoard") as! [[String:String]]
                    data.append(lastKill)
                    UserDefaults.standard.set(data, forKey: "ScoreBoard")
                }
                else {
                    UserDefaults.standard.set([lastKill], forKey: "ScoreBoard")
                }
                print(UserDefaults.standard.array(forKey: "ScoreBoard"))
                return
            }
        }
    }
    
    var counter = 0
    var buttonsCross = Array<Any>()
    var buttonsNought = Array<Any>()

    
    @IBAction func Buttons(_ sender: UIButton) {
        let index = Int(sender.accessibilityIdentifier!)

        if(counter % 2 == 0)
        {
            sender.setBackgroundImage(#imageLiteral(resourceName: "cross.png"), for: .normal)
            sender.isEnabled = false
            buttonsCross.append(index!)
        }
        else if(counter % 2 != 0)
        {
            sender.setBackgroundImage(#imageLiteral(resourceName: "circle.png"), for: .normal)
            sender.isEnabled = false
            buttonsNought.append(index!)
        }
        counter += 1
        gamePlay()
        
        if(winner == "Nought" || winner == "Cross"){
            
            let alert = UIAlertController(title: "Congrats", message: "Player "+winner+" win", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Great", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert,animated: true, completion: nil)
        }
        else if(counter == 9) {
            
            let lastKill = ["winner":"Draw","loser":""]
            if(UserDefaults.standard.array(forKey: "ScoreBoard") != nil){
                var data  = UserDefaults.standard.array(forKey: "ScoreBoard") as! [[String:String]]
                data.append(lastKill)
                UserDefaults.standard.set(data, forKey: "ScoreBoard")
            }
            else {
                UserDefaults.standard.set([lastKill], forKey: "ScoreBoard")
            }
            
            let alert = UIAlertController(title: "Draw", message: "This is a draw", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Great", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert,animated: true, completion: nil)
            
            
        }
    }
}
