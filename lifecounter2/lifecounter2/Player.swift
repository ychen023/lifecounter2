//
//  Player.swift
//  lifecounter2
//
//  Created by Yilin Chen on 4/28/22.
//

import Foundation
import UIKit

class Player {
    var score : Int
    //var input : String = PlayViewController().inputScore.text!
    
    var value: Int = 5
    var name: String = ""
    
    init(score : Int, name : String) {
        self.score = score
        self.name = name
    }
    
    func add() {
        score += value

    }
    
    func subtract() {
        score -= value
        if score < 0 {
            score = 0
        }
    }
}
