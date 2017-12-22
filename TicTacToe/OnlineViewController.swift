//
//  OnlineViewController.swift
//  TicTacToe
//
//  Created by Michael Guerfi on 18/12/2017.
//  Copyright © 2017 Michael Guerfi. All rights reserved.
//

import UIKit
import SocketIO

class OnlineViewController: UIViewController {
    
    let socket = TTTSocket.sharedInstance.socket.defaultSocket
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.socket.on("join_game") { data, ack in
            print(data)
            self.performSegue(withIdentifier: "OnlinePlayModal", sender: "")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playOnline(_ sender: UIButton) {
        self.socket.emit("join_queue", "Michael")
    }
    
    
}
