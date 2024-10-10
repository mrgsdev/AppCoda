//
//  PaymentCategory.swift
//  Chapter 25
//
//  Created by mrgsdev on 10.10.2024.
//


import Foundation
import SwiftData

enum PaymentCategory: Int {
    case income = 0
    case expense = 1
}

@Model class PaymentActivity  {
    @Attribute(.unique) var paymentId: UUID
    var date: Date
    var name: String
    var address: String?
    var amount: Double
    var memo: String?
    @Transient var type: PaymentCategory {
        get {
            PaymentCategory(rawValue: Int(typeNum)) ?? .expense
        }
        
        set {
            self.typeNum = Int(newValue.rawValue)
        }
    }
    @Attribute(originalName: "type") var typeNum: PaymentCategory.RawValue
    
    init(paymentId: UUID = UUID(), date: Date, name: String, address: String? = nil, amount: Double, memo: String? = nil, type: PaymentCategory) {
        self.paymentId = paymentId
        self.date = date
        self.name = name
        self.address = address
        self.amount = amount
        self.memo = memo
        self.type = type
    }
}

