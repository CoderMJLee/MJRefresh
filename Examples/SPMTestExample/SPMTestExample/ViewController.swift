//
//  ViewController.swift
//  SPMTestExample
//
//  Created by Frank on 2021/11/19.
//

import UIKit
import MJRefresh

class ViewController: UITableViewController {
    
    var itemsCount = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MJRefreshNormalHeader {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                guard let self = self else { return }
                
                self.itemsCount += Int.random(in: 1...5)
                self.tableView.reloadData()
                
                self.tableView.mj_header?.endRefreshing()
            }
        }.autoChangeTransparency(true).link(to: self.tableView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

