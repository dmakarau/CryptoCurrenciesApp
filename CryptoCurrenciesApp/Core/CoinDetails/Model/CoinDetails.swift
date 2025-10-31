//
//  CoinDetails.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 29.10.25.
//

import Foundation

struct CoinDetails: Codable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
}

struct Description: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
