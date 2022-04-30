//
//  TableViewCell.swift
//  lifecounter2
//
//  Created by Yilin Chen on 4/28/22.
//

import UIKit


protocol CustomCellUpdater: AnyObject { // the name of the protocol you can put any
    func updateTableView()
}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    
    var player: Player!
    var parentVC: UIViewController!
    weak var delegate: CustomCellUpdater?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
    

    func configureCell() {
        scoreLabel.text = "\(player.score)"
        playerName.text = player.name
    }
    
    
    @IBAction func plusTouched(_ sender: Any) {
        player.add()
        scoreLabel.text = "\(player.score)"

        history.append("\(player.name) gained \(player.value) life.")
    }
    
    @IBAction func minusTouched(_ sender: Any) {
        player.subtract()
        scoreLabel.text = "\(player.score)"
        
        history.append("\(player.name) lost \(player.value) life.")
        
        if player.score == 0 {
            let alertController = UIAlertController(title: "Game Over", message: "Click OK to reset the game", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { _ in
                allPlayers = [
                    Player(score:20, name: "Player 1"),
                    Player(score:20, name: "Player 2"),
                    Player(score:20, name: "Player 3"),
                    Player(score:20, name: "Player 4")
                ]
                history = []
                self.delegate?.updateTableView()
            }))
            parentVC.present(alertController, animated: true, completion: nil)
        }
    }
}

