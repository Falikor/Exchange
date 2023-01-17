//
//  NetworkingProtocol.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import Foundation
import Combine

public protocol NetworkingProtocol {
    func exrcute<T: Decodable>(_: T.Type, request: URLRequest) -> AnyPublisher<T, Error>
}
