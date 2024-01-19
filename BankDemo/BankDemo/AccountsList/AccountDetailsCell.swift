//
//  AccountDetailsCell.swift
//  BankDemo
//
//  Created by Vibhor Singla on 18/01/24.
//

import Foundation
import UIKit

class AccountDetailsCell: UITableViewCell {
    
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    func renderValues(account : Accounts){
        self.typeLbl?.text = account.type
        self.balanceLbl?.text = String(account.balance)
        self.numberLbl?.text = account.number
    }
}

