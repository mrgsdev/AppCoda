//
//  Loan.swift
//  Chapter 4
//
//  Created by mrgsdev on 22.04.2024.
//

import Foundation
 
struct Loan: Hashable, Codable {
    
    var name: String = ""
    var country: String = ""
    var use: String = ""
    var amount: Int = 0

    enum CodingKeys: String, CodingKey {
        case name
        case country = "location"
        case use
        case amount = "loan_amount"
    }
    
    enum LocationKeys: String, CodingKey {
        case country
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        
        let location = try values.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
        country = try location.decode(String.self, forKey: .country)
        
        use = try values.decode(String.self, forKey: .use)
        amount = try values.decode(Int.self, forKey: .amount)
        
    }
}


struct LoanDataStore: Codable {
    var loans: [Loan]
}
 
 
