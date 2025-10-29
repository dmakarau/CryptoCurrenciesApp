//
//  CoinDetailsView.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 29.10.25.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: Coin
    let viewModel: CoinDetailsViewModel
    
    init(coin: Coin) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coinId: coin.id)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let details = viewModel.coinDetails {
                HStack {
                    AsyncImage(url: URL(string: coin.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(details.name)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                }
                Text(coin.symbol.uppercased())
                    .font(.footnote)
                Text(details.description.text)
                    .font(.footnote)
                    .padding(.vertical)
            }
        }
        .task {
            await viewModel.fetchCoinDetails(for: coin.id)
        }
        .padding()
    }
}
