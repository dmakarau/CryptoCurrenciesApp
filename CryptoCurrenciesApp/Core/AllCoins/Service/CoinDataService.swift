//  CoinDataService.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 24.10.25.
//

import Foundation


class CoinDataService {
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&sparkline=false&price_change_percentage=24h"
    
    func fetchCoins() async throws -> [Coin] {
        guard let url = URL(string: urlString) else { return [] }
                
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinAPIError.requestFailed(description: "Bad response")
        }
        guard httpResponse.statusCode == 200 else {
            throw CoinAPIError.invalidStatusCode(code: httpResponse.statusCode)
        }
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: data)
            return coins
            
        } catch {
            print("DEBUG-> Error fetching coins: \(error)")
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
}

// MARK: - Completion Handling

extension CoinDataService {
    func fetchCoinsWithResult(completion: @escaping (Result<[Coin], CoinAPIError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Bad response")))
                return
            }
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(code: httpResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            let datastring = String(data: data, encoding: .utf8)
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            } catch {
                print("DEBUG-> Failed to decode JSON witch error: \(error.localizedDescription), data: \(String(describing: datastring))")
                completion(.failure(.jsonParsingError))
            }
        }.resume()
    }
    
    func fetchPrice(coin: String, currency: String, completion: @escaping(Double) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?vs_currencies=\(currency)&ids=\(coin)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG-> Error fetching data: \(error.localizedDescription)")
                //                self.errorMessage = error.localizedDescription
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                //                self.errorMessage = "Bad response"
                return
            }
            guard httpResponse.statusCode == 200 else {
                //                self.errorMessage = "HTTP Error: \(httpResponse.statusCode)"
                return
            }
            print("DEBUG-> HttpResponse Status Code: \(httpResponse.statusCode)")
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("DEBUG-> Failed to get coin data from JSON \(jsonObject)")
                return
            }
            guard let price = value[currency] else { return }
            //                self.coin = coin.capitalized
            //                self.price = "\(price)"
            print("DEBUG: Price in service: \(price) for coin: \(coin) in currency: \(currency)")
            completion(price)
            
        }.resume()
    }
}
