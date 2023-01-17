//
//  Networking.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import Foundation
import Combine

struct Networking: NetworkingProtocol {
    func exrcute<T>(_: T.Type, request: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        do {
            return URLSession.shared
                .dataTaskPublisher(for: request)
                .tryMap { data, _ in
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    return result
                }
                .eraseToAnyPublisher()
        } catch {
            return Future<T, Error> { promis in
                promis(.failure(error))
            }
            .eraseToAnyPublisher()
        }
    }
}
