//
//  AccountDetails.swift
//  BankDemo
//
//  Created by Vibhor Singla on 19/01/24.
//

import SwiftUI

struct AccountDetailsView: View {
    @State var accountDetail = AccountDetail(transactions: [])
    @State var isSort = true
    @State private var userValue: Int = 0

    var body: some View {
        HStack{
            Spacer(minLength: 5)
            Button("Order By Date"){
                if isSort {
                    accountDetail.transactions.sort(by:  ({$0.date > $1.date}))
                    isSort = false
                } else{
                    accountDetail.transactions.sort(by:  ({$0.date < $1.date}))
                    isSort = true
                }}
            Spacer(minLength: 20)
            TextField("Enter Value",
                      value: $userValue,
                      formatter: NumberFormatter(),
                      onEditingChanged: { (isBegin) in
                              if isBegin {
                              }
                          },
                      onCommit: {
                    accountDetail.transactions = accountDetail.transactions.filter({ (transaction:Transaction) -> Bool in
                        return userValue > 0 ? transaction.value >= userValue : transaction.value <= userValue
                    })
            })
            Spacer(minLength: 10)
            Button("Reload"){
                fetchTransactions()
            }
            Spacer(minLength: 10)
        }
        
        List (accountDetail.transactions, id: \.date){transcation in
            VStack{
                Text("Transcation Type: \(transcation.type)")
                    .font(.subheadline)
                Text("Transcation Value: \(transcation.value)")
                    .font(.subheadline)
                Text("Transcation Date: \(Date.init(timeIntervalSince1970: transcation.date))")
                    .font(.subheadline)
            }
        }
        .onAppear{
            fetchTransactions()
        }
    }
    func fetchTransactions() {
        NetworkManager().getTransactions {result in
            switch result{
            case .success(var accountDetail):
                DispatchQueue.main.async {
                    accountDetail.transactions.sort(by:  ({$0.date < $1.date}))
                    self.accountDetail = accountDetail
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        }
}

struct AccountDetails_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailsView()
    }
}
