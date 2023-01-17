//
//  CurrencySelectionView.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import SwiftUI

struct CurrencySelectionView: View {
    @Binding var selectToCurrency: String
    @Binding var selectFromCurrency: String
    let allCurrency: [String : String]
    let onClose: () -> Void

    init(
        selectToCurrency: Binding<String>,
        selectFromCurrency: Binding<String>,
        allCurrency: [String : String],
        onClose: @escaping () -> Void
    ) {
        self._selectToCurrency = selectToCurrency
        self._selectFromCurrency = selectFromCurrency
        self.allCurrency = allCurrency
        self.onClose = onClose
    }

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Picker("To", selection: $selectToCurrency) {
                        ForEach(allCurrency.sorted(by: >), id: \.key) { key, value in
                            if key != selectFromCurrency {
                                Text(key)
                            }
                        }
                    }
                    Text(allCurrency[selectToCurrency] ?? "")
                        .lineLimit(2)
                }
                .padding(.all, 10)
                Spacer()
                VStack {
                    Picker("From", selection: $selectFromCurrency) {
                        ForEach(allCurrency.sorted(by: <), id: \.key) { key, value in
                            if key != selectToCurrency {
                                Text(key)
                            }
                        }
                    }
                    Text(allCurrency[selectFromCurrency] ?? "")
                        .lineLimit(2)
                }
                .padding(.all, 10)
            }
            Button(action: {
                onClose()
            }) {
                Text("Добавить валютуню пару")
            }
        }
        Spacer()
    }
}
