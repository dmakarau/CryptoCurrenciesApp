//
//  ContentView.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 17.10.25.
//

import SwiftUI

struct ContentView: View {
    var viewModel = CoinsViewModel()
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
                        .font(.footnote)
                    }
                    
                }
            }
            .navigationDestination(for: Coin.self, destination: { coin in
                CoinDetailsView(coin: coin)
            })
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
