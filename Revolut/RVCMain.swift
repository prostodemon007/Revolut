//
//  RVCMain.swift
//  Revolut
//
//  Created by Oleg Ulitsionak on 04.07.16.
//  Copyright © 2016 Alexei Rudakov. All rights reserved.
//

import UIKit

class RVCMain: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        self.view .addSubview(tableView)
        
        self.view.showActivity()
        ExchangeManager.refresh { (succees) in
            User.currentUser.fillBalance()
            self.tableView.reloadData()
            self.view.hideActivity()
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Exhange", style: .Plain, target: self, action: #selector(onExchange))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    func onExchange() {
        let vc = RVCExchange()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return User.currentUser.balances.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("kCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "kCell")
        }
        let balance = User.currentUser.balances[indexPath.row]
        
        cell.textLabel?.text = balance.currency.shortName
        cell.detailTextLabel?.text = "\(Float(Int(balance.amount * 100)) / 100)"
        cell.selectionStyle = .None
        return cell
    }

}
