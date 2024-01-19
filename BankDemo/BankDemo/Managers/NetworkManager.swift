//
//  NetworkManager.swift
//  BankDemo
//
//  Created by Vibhor Singla on 18/01/24.
//

import Foundation

class NetworkManager {
    
    public func getAccounts(completion: @escaping (Result<[Accounts], Error>) -> ())  {
        let url = URL(string: "https://m.timwang.au/accounts.json")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
        if let data = data {
        do {
            let result = try JSONDecoder().decode([Accounts].self, from: data)
            completion(.success(result))
            } catch {
                completion(.failure(error))
            }}
        }
        task.resume()
    }
    public func getTransactions(completion: @escaping (Result<AccountDetail, Error>) -> ()){
        let url = URL(string: "https://m.timwang.au/transactions.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(AccountDetail.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
