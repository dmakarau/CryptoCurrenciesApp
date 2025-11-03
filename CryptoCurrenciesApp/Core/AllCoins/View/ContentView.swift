//
//  ContentView.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 17.10.25.
//

import SwiftUI

struct ContentView: View {
    private let service: CoinServiceProtocol
    var viewModel: CoinsViewModel
    
    init(service: CoinServiceProtocol) {
        self.service = service
        self.viewModel = CoinsViewModel(service: service)
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.coins) { coin in
                    NavigationLink(value: coin) {
                        HStack(spacing: 12) {
                            Text("\(coin.marketCapRank)")
                                .foregroundStyle(.gray)
                            AsyncImage(url: URL(string: coin.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                            } placeholder: {
                                ProgressView()
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(coin.name)
                                    .fontWeight(.semibold)
                                Text(coin.symbol.uppercased())
                            }
                        }
                        .onAppear {
                            if coin == viewModel.coins.last {
                                Task { await viewModel.fetchCoins() }
                            }
                        }
                    }
                    .font(.footnote)
                }
                
            }
            
            .navigationDestination(for: Coin.self, destination: { coin in
                CoinDetailsView(coin: coin, serivce: service)
            })
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
}

#Preview {
    ContentView(service: CoinDataService())
}
