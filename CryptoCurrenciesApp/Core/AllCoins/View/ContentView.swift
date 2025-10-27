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
        VStack {
            List {
                ForEach(viewModel.coins) { coin in
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
