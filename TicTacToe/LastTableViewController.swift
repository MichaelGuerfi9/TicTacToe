//
//  LastTableViewController.swift
//  TicTacToe
//
//  Created by Michael Guerfi on 06/11/2017.
//  Copyright © 2017 Michael Guerfi. All rights reserved.
//

import UIKit

class LastTableViewController: UITableViewController {
    
    var data = Array<[String: String]>()
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.array(forKey: "ScoreBoard") != nil){
            data = UserDefaults.standard.array(forKey: "ScoreBoard") as! [[String : String]]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(UserDefaults.standard.array(forKey: "ScoreBoard"))
        if(UserDefaults.standard.array(forKey: "ScoreBoard") != nil){
            data = UserDefaults.standard.array(forKey: "ScoreBoard") as! [[String : String]]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LastCell", for:indexPath)
        
        cell.textLabel?.text = "\(data[indexPath.row]["winner"]!) Killed \(data[indexPath.row]["loser"]!)"

        return cell
    }
}
