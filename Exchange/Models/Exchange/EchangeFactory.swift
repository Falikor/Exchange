//
//  EchangeFactory.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import Foundation
import UIKit
// TODO: Ruter и Cordinator чтобы модули могли общаться 
protocol EchangeFactoryProtocol {
    func createListEchangeView() -> ListEchangeView
}

final class EchangeFactory: EchangeFactoryProtocol {
    private var networking: NetworkingProtocol

    init(
        networking: NetworkingProtocol
    ) {
        self.networking = networking
    }

    func createListEchangeView() -> ListEchangeView {
        let interactor = ExchangeInteractor(networking: networking)
        let viewModel = ListEchangeViewModel(interactor: interactor)
        return ListEchangeView(viewModel: viewModel)
    }
}
