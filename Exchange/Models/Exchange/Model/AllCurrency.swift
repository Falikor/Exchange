//
//  AllCurrency.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import Foundation

struct AllCurrency: Codable, Equatable, Hashable {
    let success: Bool?
    let symbols: [String: String]?
}
