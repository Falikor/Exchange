//
//  ExchangeInteractorStub.swift
//  ExchangeTests
//
//  Created by Бугреев Виктор Викторович on 17.01.2023.
//

import Foundation
import Combine

class ExchangeInteractorStub: ExchangeInteractorProtocol {

    func echange(to: String, from: String) -> AnyPublisher<EchangeNetworkModel, Error>? {
        return Just(
            EchangeNetworkModel.init(
                date: "",
                info: Info.init(rate: 0, timestamp: 0),
                query: Query.init(amount: nil, from: "RUB", to: "EUR"),
                result: 73.73,
                success: true
            )
        )
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    func allCurrency() -> AnyPublisher<AllCurrency, Error>? {
        return Just(AllCurrency.init(
            success: true,
            symbols: ["RUB" : "RF", "EUR" : "ES"])
        )
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

class NetworkingStub: NetworkingProtocol {
    private(set) var count = 0
    func exrcute<T>(_: T.Type, request: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        count += 1
        return Empty().eraseToAnyPublisher()
    }
}
