//
//  historyViewController.swift
//  lifecounter2
//
//  Created by Yilin Chen on 4/29/22.
//

import UIKit

class historyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var historyTable: UITableView!
    
    let cellReuseIdentifier = "historyCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        historyTable.delegate = self
        historyTable.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = historyTable.dequeueReusableCell(withIdentifier: "historyCell") {
            cell.textLabel?.text = "\(history.count - indexPath.row) - \(history[history.count - indexPath.row - 1])"
        return cell
        }
        return UITableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historyTable.reloadData()
    }

}
