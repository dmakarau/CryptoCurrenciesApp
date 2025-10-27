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
        fetchCoins()
    }
    
    func fetchCoins() {
  
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
