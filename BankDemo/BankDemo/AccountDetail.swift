//
//  AccountDetails.swift
//  BankDemo
//
//  Created by Vibhor Singla on 19/01/24.
//

import Foundation

struct AccountDetail: Codable {
    var transactions: [Transaction]
}

struct Transaction: Codable {
    let value: Int
    let type: String
    let date : Double
}
