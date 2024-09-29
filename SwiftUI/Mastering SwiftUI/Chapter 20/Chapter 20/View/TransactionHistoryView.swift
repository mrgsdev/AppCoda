//
//  TransactionHistoryView.swift
//  Chapter 20
//
//  Created by mrgsdev on 29.09.2024.
//


import SwiftUI

struct TransactionHistoryView: View {
    
    var transactions: [Transaction]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Transaction History")
                .font(.system(size: 25, weight: .black, design: .rounded))
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(transactions) { transaction in
                        TransactionView(transaction: transaction)
                    }
                }
                .padding()
            }
        }
    }
}

struct TransactionView: View {
    
    var transaction: Transaction
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(UIColor.systemGray5))
            .overlay(
                VStack {
                    Spacer()
                    
                    Image(systemName: transaction.icon)
                        .font(.system(size: 50))
                        .padding(.bottom, 10)
                    
                    Text(transaction.merchant)
                        .font(.system(.body, design: .rounded))
                        .bold()
                    
                    Text("$\(String(format: "%.1f", transaction.amount))")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding(.bottom, 30)
                    
                    Text(transaction.date)
                        .font(.system(.caption, design: .rounded))
                    
                    Spacer()
                }
                    
            )
            .frame(width: 200, height: 300)
            
    }
}

#Preview("Transaction History View") {
    TransactionHistoryView(transactions: testTransactions)
}

#Preview("Transaction View") {
    TransactionView(transaction: testTransactions[0])
}
