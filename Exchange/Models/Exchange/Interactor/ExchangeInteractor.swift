//
//  ExchangeInteractor.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import Foundation
import Combine

class ExchangeInteractor: ExchangeInteractorProtocol {
    let networking: NetworkingProtocol

    init(
        networking: NetworkingProtocol
    ) {
        self.networking = networking
    }
// TODO: Сделать кастомный Request
    func echange(to: String, from: String) -> AnyPublisher<EchangeNetworkModel, Error>?  {
        let stringUrl = "https://api.apilayer.com/exchangerates_data/convert?to=\(to)&from=\(from)&amount=1"
        guard let url = URL(string: stringUrl) else { return nil }
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("rDWbRBHc3kPckkdfCvxzX86iaGOMDdgD", forHTTPHeaderField: "apikey")

        return networking.exrcute(EchangeNetworkModel.self, request: request)
    }

    func allCurrency() -> AnyPublisher<AllCurrency, Error>? {
        let stringUrl = "https://api.apilayer.com/exchangerates_data/symbols"
        guard let url = URL(string: stringUrl) else { return nil }
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("rDWbRBHc3kPckkdfCvxzX86iaGOMDdgD", forHTTPHeaderField: "apikey")

        return networking.exrcute(AllCurrency.self, request: request)
    }

}
