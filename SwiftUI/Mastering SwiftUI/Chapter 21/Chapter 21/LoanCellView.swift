//
//  LoanCellView.swift
//  Chapter 21
//
//  Created by mrgsdev on 29.09.2024.
//


import SwiftUI

struct LoanCellView: View {
    
    var loan: Loan
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(loan.name)
                    .font(.system(.headline, design: .rounded))
                    .bold()
                Text(loan.country)
                    .font(.system(.subheadline, design: .rounded))
                Text(loan.use)
                    .font(.system(.body, design: .rounded))
            }
            
            Spacer()
            
            VStack {
                Text("$\(loan.amount)")
                    .font(.system(.title, design: .rounded))
                    .bold()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        
    }
}

#Preview {
    LoanCellView(loan: Loan(name: "Ivan", country: "Uganda", use: "to buy a plot of land", amount: 575))
}
