//
//  PlayOnlineViewController.swift
//  TicTacToe
//
//  Created by Michael Guerfi on 18/12/2017.
//  Copyright © 2017 Michael Guerfi. All rights reserved.
//


import UIKit
import SocketIO

class PlayOnlineViewController: UIViewController {
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {}
    }
    
    @IBOutlet var buttons: [UIButton]!
    let socket = TTTSocket.sharedInstance.socket.defaultSocket
    var counter = 0;
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.socket.on("movement") { data, ack in
            self.counter += 1
            let array = data as Array<Any>
            let response = array[0] as! [String:Any]
            if(self.counter == 9){
                let alert = UIAlertController(title: "End of the game", message: "This is a draw", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Great", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction!) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert,animated: true, completion: nil)
            }
            else {
                if(response["err"] is NSNull){
                    let id = response["index"] as! Int
                    print(id)
                    let player = response["player_played"] as! String
                    for button in self.buttons{
                        if(Int(button.accessibilityIdentifier!) == id + 1){
                            if(player == "o"){
                                button.setBackgroundImage(#imageLiteral(resourceName: "circle.png"), for: .normal)
                                button.isEnabled = false;
                            }
                            else {
                                button.setBackgroundImage(#imageLiteral(resourceName: "cross.png"), for: .normal)
                                button.isEnabled = false;
                            }
                        }
                        if(response["win"] != nil && response["win"] as! Bool == true){
                            let winner = response["player_played"] as! String
                            let alert = UIAlertController(title: "End of the game", message: "Player "+winner+" win", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Great", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction!) in
                                self.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert,animated: true, completion: nil)
                        }
                    }
                }
                else
                {
                    print(response["err"])
                }
            }
        }
    }
    
    @IBAction func Buttons(_ sender: UIButton) {
        var index = Int(sender.accessibilityIdentifier!)
        index = index! - 1
        self.socket.emit("movement",index!)
        
    }
}
