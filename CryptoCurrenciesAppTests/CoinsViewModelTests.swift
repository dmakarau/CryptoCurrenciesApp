//
//  CoinsViewModelTests.swift
//  CryptoCurrenciesAppTests
//
//  Created by Denis Makarau on 03.11.25.
//

import Foundation
import XCTest
@testable import CryptoCurrenciesApp

@MainActor
class CoinsViewModelTests: XCTestCase {
    func testInit() {
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        XCTAssertNotNil(viewModel, "The view model should be initialized properly.")
    }
    
    func testSuccessfulCoinsFetch() async {
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()
        XCTAssertTrue(viewModel.coins.count > 0, "The coins array should not be empty after a successful fetch.")
        XCTAssertEqual(viewModel.coins.count, 20)
        XCTAssertEqual(viewModel.coins, viewModel.coins.sorted(by: { $0.marketCapRank < $1.marketCapRank }))
    }
    
    func testCoinFetchWithInvalidJSON() async {
        let service = MockCoinService()
        service.mockData = mockCoins_invalidJson
        let viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()
        XCTAssertTrue(viewModel.coins.isEmpty, "The coins array should be empty when fetching with invalid JSON.")
        XCTAssertNotNil(viewModel.errorMessage, "An error message should be set when fetching fails due to invalid JSON.")
    }
    
    func testThrowsInvalidDataError() async {
        let service = MockCoinService()
        service.mockError = .invalidData
        let viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()
        XCTAssertNotNil(viewModel.errorMessage, "An error message should be set when fetching fails due to invalid data.")
        XCTAssertEqual(viewModel.errorMessage, CoinAPIError.invalidData.customDescription)
    }
    
    func testThrowsStatusCode() async {
        let service = MockCoinService()
        service.mockError = .invalidStatusCode(code: 404)
        let viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()
        XCTAssertNotNil(viewModel.errorMessage, "An error message should be set when fetching fails due to invalid data.")
        XCTAssertEqual(viewModel.errorMessage, CoinAPIError.invalidStatusCode(code: 404).customDescription)
    }
}
