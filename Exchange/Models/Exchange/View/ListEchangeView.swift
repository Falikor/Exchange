//
//  ListEchangeView.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import SwiftUI

struct ListEchangeView: View {
    @ObservedObject var viewModel: ListEchangeViewModel
    // TODO: Сделать компоненты кастомной ячейки и Button
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                List {
                    ForEach(viewModel.echangeCoreModels, id: \.self) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("1 \(item.to)")
                                Text(item.subTitelTo)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                    .frame(width: 100, alignment: .leading)
                            }
                            .multilineTextAlignment(.leading)
                            Spacer()
                            Text("\(item.result)")
                                .foregroundColor(
                                    ExchangeUpDown.init(
                                        rawValue: item.exchangeUpDown
                                    )?.wrappedValue)
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(item.from)
                                Text(item.subTitelFrom)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                    .frame(width: 100, alignment: .trailing)
                            }
                            .multilineTextAlignment(.trailing)
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                .listStyle(GroupedListStyle())
                .sheet(isPresented: $viewModel.currencyBottomSheetPresentes) {
                    CurrencySelectionView(
                        selectToCurrency: $viewModel.selectToCurrency,
                        selectFromCurrency: $viewModel.selectFromCurrency,
                        allCurrency: viewModel.allCurrency
                    ) {
                        viewModel.currencyBottomSheetPresentes = false
                        viewModel.loadExchange(
                            to: viewModel.selectToCurrency,
                            from: viewModel.selectFromCurrency
                        )
                    }
                    .presentationDetents([.medium, .large])
                }
                Button(action: {
                    viewModel.showCurrencySelectionSheet()
                }) {
                    HStack(alignment: .center, spacing: 20) {
                        Image(systemName: "plus.circle.fill")
                        Text("Добавить валютуню пару")
                    }
                }
            }
            .navigationBarTitle("Курс валютных пар", displayMode: .inline)
        }
    }

    func deleteItem(at offsets: IndexSet) {
        offsets.forEach {
            let item = viewModel.echangeCoreModels[$0]
            viewModel.delete(item)
        }
        viewModel.getAllExchangeModelCore()
    }
}
