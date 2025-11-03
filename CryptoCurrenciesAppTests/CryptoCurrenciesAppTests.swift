//
//  CryptoCurrenciesAppTests.swift
//  CryptoCurrenciesAppTests
//
//  Created by Denis Makarau on 03.11.25.
//

import XCTest
@testable import CryptoCurrenciesApp

final class CryptoCurrenciesAppTests: XCTestCase {
    
    func test_DecodeCoinsIntoArray_marketCapDesc() throws {
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockCoinsData_marketCapDesc)
            // Make sure that there are coins in the array
            XCTAssertTrue(coins.count > 0)
            // Verify number of coins decoced
            XCTAssertEqual(coins.count, 20)
            // Verify sorting order
            XCTAssertEqual(coins, coins.sorted(by: { $0.marketCapRank < $1.marketCapRank }))
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
