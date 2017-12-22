//
//  ViewController.swift
//  TicTacToe
//
//  Created by Michael Guerfi on 25/10/2017.
//  Copyright © 2017 Michael Guerfi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        TTTSocket.sharedInstance.socket.defaultSocket.on("test") { data, ack in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func PlayAction(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "PlayModal", sender: "")
        
    }
    
    

}

