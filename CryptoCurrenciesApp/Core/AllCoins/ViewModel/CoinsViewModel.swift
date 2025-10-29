//
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 17.10.25.
//

import Foundation

@Observable
class CoinsViewModel {
    
    var coins = [Coin]()
    var errorMessage: String?
    
    private let service = CoinDataService()
    
    init() {
        Task { await fetchCoins() }
    }
    
    func fetchCoins() async {
        do {
            self.coins = try await service.fetchCoins()
        } catch {
            guard let error = error as? CoinAPIError else { return }
            self.errorMessage = error.customDescription
        }
    }
    
    func fetchCoinsWithCompletionHandler() {
        service.fetchCoinsWithResult { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
