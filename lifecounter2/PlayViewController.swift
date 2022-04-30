//
//  ViewController.swift
//  lifecounter2
//
//  Created by Yilin Chen on 4/26/22.
//

import UIKit

var history : [String] = []
var allPlayers: [Player] = [
    Player(score:20, name: "Player 1"),
    Player(score:20, name: "Player 2"),
    Player(score:20, name: "Player 3"),
    Player(score:20, name: "Player 4")
]

class PlayViewController: UIViewController, UITextFieldDelegate, CustomCellUpdater {
    func updateTableView() {
        tableView.reloadData()
        inputScore.text = "5"
    }
    
    
    @IBOutlet weak var inputScore: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addPlayer: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    let numberToolbar: UIToolbar = UIToolbar()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        inputScore.delegate = self
        
        numberToolbar.barStyle = UIBarStyle.default
           numberToolbar.items=[
            UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.boopla)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Apply", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.hoopla))
           ]

            numberToolbar.sizeToFit()
        inputScore.inputAccessoryView = numberToolbar

    }
    
    @objc func boopla () {
        inputScore.resignFirstResponder()
    }

    @objc func hoopla () {
        if let text = inputScore.text {
            for player in allPlayers {
                player.value = Int(text)!
            }
        }
        inputScore.resignFirstResponder()
    }
    
    func updateViews() {
        tableView.reloadData()
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let text = inputScore.text {
//            for player in allPlayers {
//                player.value = Int(text)!
//            }
//        }
//        return true
//    }

    @IBAction func resetTouched(_ sender: Any) {
        history = []
        allPlayers = [
            Player(score:20, name: "Player 1"),
            Player(score:20, name: "Player 2"),
            Player(score:20, name: "Player 3"),
            Player(score:20, name: "Player 4")
        ]
        inputScore.text = "5"
        
        updateViews()
    }
    
    
    @IBAction func addPlayerTouched(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Player", message: "", preferredStyle: .alert)

        alertController.addTextField { (textField) in textField.placeholder = "New Player Name" }
        
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: {_ in
            let newPlayerName = alertController.textFields![0]
            self.addPlayer(newPlayerName.text!)
            })
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        var disable : Bool = false
        for player in allPlayers {
            if player.score != 20 {
                disable = true
            }
        }
        
        if allPlayers.count < 8 && disable == false {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func addPlayer(_ playerName : String) {
        if playerName != "" {
            allPlayers.append(Player(score:20, name: playerName))
        } else {
            allPlayers.append(Player(score:20, name: "New Player"))
        }
        
        updateViews()
        history.append("\(playerName) joined game.")
    }
}


extension PlayViewController: UITableViewDelegate {
    func tableView(_tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension PlayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allPlayers.count
    }

    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//       let cell = tableView.dequeueReusableCell(withIdentifier: "yourIdentifier", for: indexPath) as! YourTableViewCell
//       cell.delegate = self
//    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            cell.delegate = self
            cell.player = allPlayers[indexPath.section]
            cell.configureCell()
            cell.parentVC = self

        return cell
        }

        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit Player Name", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in textField.placeholder = "New Player Name" }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let updatedPlayerName = alert!.textFields![0]
            self.editName(cell: indexPath.section, newName: updatedPlayerName.text!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func editName(cell : Int, newName : String) {
        history.append("\(allPlayers[cell].name) changed name to \(newName)")
        allPlayers[cell].name = newName
        updateViews()
        
    }
    
}
