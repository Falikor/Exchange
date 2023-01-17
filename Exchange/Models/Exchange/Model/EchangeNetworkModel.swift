//
//  EchangeNetworkModel.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import Foundation


// MARK: - EchangeNetworkModel
struct EchangeNetworkModel: Codable, Equatable, Hashable {
    let date: String?
    let info: Info?
    let query: Query?
    let result: Double?
    let success: Bool?
}

// MARK: - Info
struct Info: Codable, Equatable, Hashable {
    let rate: Double?
    let timestamp: Int?
}

// MARK: - Query
struct Query: Codable, Equatable, Hashable {
    let amount: Int?
    let from, to: String?
}
