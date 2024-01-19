//
//  AccountsViewController.swift
//  BankDemo
//
//  Created by Vibhor Singla on 18/01/24.
//

import UIKit
import SwiftUI

class AccountsViewController: UITableViewController {

    let cellID = "cell"
    var accounts : [Accounts] = []
    
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getAccountsDetails()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? AccountDetailsCell {
            cell.renderValues(account: accounts[indexPath.row])
            return cell
         }
         return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let host = UIHostingController(rootView: AccountDetailsView())
        navigationController?.pushViewController(host, animated: true)
    }
    
    func registerCell(){
        let accountDetailsCell = UINib(nibName: "AccountDetailsCell", bundle: nil)
        tableView.register(accountDetailsCell, forCellReuseIdentifier: cellID)
    }
    func getAccountsDetails(){
        networkManager.getAccounts {result in
            switch result{
            case .success(let accounts):
                DispatchQueue.main.async {
                    self.accounts = accounts
                    self.accounts.sort(by: ({$0.number < $1.number}))
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
