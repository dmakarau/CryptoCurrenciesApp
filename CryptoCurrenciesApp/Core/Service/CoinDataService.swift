//  CoinDataService.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 24.10.25.
//

import Foundation

protocol CoinServiceProtocol {
    func fetchCoins() async throws -> [Coin]
    func fetchCoinDetails(id: String) async throws -> CoinDetails?
}

class CoinDataService: CoinServiceProtocol, HTTPDataDownloader {
    
    private var page = 0
    private let fetchLimit = 20
    
    func fetchCoins() async throws -> [Coin] {
        page += 1
        guard let endpoint = allCoinsUrlString else {
            throw CoinAPIError.requestFailed(description: "Invalid URL")
        }
        return try await fetchData(as: [Coin].self, endpoint: endpoint)
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        if let cached = CoinDetailsCache.shared.get(forKey: id) {
            return cached
        }
        guard let urlDetails = coinDetailsUrlString(id: id) else {
            throw CoinAPIError.requestFailed(description: "Invalid URL")
        }
        let details = try await fetchData(as: CoinDetails.self, endpoint: urlDetails)
        CoinDetailsCache.shared.set(details, forKey: id)
        return details
    }
    
    private var baseURLComponent: URLComponents {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.coingecko.com"
        component.path = "/api/v3/coins/"
        return component
    }
    private var allCoinsUrlString: String? {
        var component = baseURLComponent
        component.path += "markets"
        component.queryItems = [
            .init(name: "vs_currency", value: "usd"),
            .init(name: "order", value: "market_cap_desc"),
            .init(name: "per_page", value: "\(fetchLimit)"),
            .init(name: "page", value: "\(page)"),
            .init(name: "sparkline", value: "false"),
            .init(name: "price_change_percentage", value: "24h")
        ]
        return component.url?.absoluteString
    }
    
    private func coinDetailsUrlString(id: String) -> String? {
        var component = baseURLComponent
        component.path += "\(id)"
        component.queryItems = [
            .init(name: "localization", value: "false")
        ]
        return component.url?.absoluteString
    }
}

// MARK: - Completion Handling

extension CoinDataService {
    func fetchCoinsWithResult(completion: @escaping (Result<[Coin], CoinAPIError>) -> Void) {
        guard let url = URL(string: allCoinsUrlString ?? "") else { return }
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
