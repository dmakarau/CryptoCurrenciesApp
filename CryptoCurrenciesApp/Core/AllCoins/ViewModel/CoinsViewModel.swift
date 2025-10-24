//
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 17.10.25.
//

import Foundation

@Observable
class CoinsViewModel {
    
    var coins = [Coin]()
   
    
    private let service = CoinDataService()
    
    init() {
//        fetchPrice(of: "bitcoin")
        fetchCoins()
    }
    
    func fetchCoins() {
        service.fetchCoins { coins in
            DispatchQueue.main.async {
                self.coins = coins
            }
        }
    }
}
