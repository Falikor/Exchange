//
//  ExchangeInteractorProtocol.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import Foundation
import Combine

protocol ExchangeInteractorProtocol {
    func echange(to: String, from: String) -> AnyPublisher<EchangeNetworkModel, Error>?
    func allCurrency() -> AnyPublisher<AllCurrency, Error>?
}
