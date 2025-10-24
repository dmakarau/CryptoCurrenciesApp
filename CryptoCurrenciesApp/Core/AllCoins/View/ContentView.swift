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
                    HStack {
                        AsyncImage(url: URL(string: coin.image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(coin.name)


                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
