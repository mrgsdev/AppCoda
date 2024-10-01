//
//  LoanFilterView.swift
//  Chapter 21
//
//  Created by mrgsdev on 29.09.2024.
//


import SwiftUI

struct LoanFilterView: View {
    
    @Binding var amount: Double
    
    var minAmount = 0.0
    var maxAmount = 10000.0
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Show loan amount below $\(Int(amount))")
                .font(.system(.headline, design: .rounded))
            
            HStack {
                
                Slider(value: $amount, in: minAmount...maxAmount, step: 100)
                    .accentColor(.purple)
                    
            }
            
            HStack {
                Text("\(Int(minAmount))")
                    .font(.system(.footnote, design: .rounded))
                
                Spacer()
                
                Text("\(Int(maxAmount))")
                .font(.system(.footnote, design: .rounded))
            }
            
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}


#Preview {
    LoanFilterView(amount: .constant(10000))
}
