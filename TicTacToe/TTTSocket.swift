//
//  TTTSocket.swift
//  TicTacToe
//
//  Created by Michael Guerfi on 13/11/2017.
//  Copyright © 2017 Michael Guerfi. All rights reserved.
//

import Foundation
import SocketIO

class TTTSocket{
    
    static let sharedInstance = TTTSocket()
    
    let socket = SocketManager(socketURL: URL(string:"http://51.254.112.146:5666")!, config: [])
    init(){
    }
    
    func establishConnection(){
        self.socket.connect()
    }
    
    func closeConnection(){
        self.socket.disconnect()
    }
}
