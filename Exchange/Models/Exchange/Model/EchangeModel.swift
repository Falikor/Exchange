//
//  EchangeModel.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import Foundation

struct EchangeModel: Codable, Equatable, Hashable {
    let to: String
    let subTitelTo: String
    let from: String
    let subTitelFrom: String
    let result: Double
    let exchangeUpDown: String

    init(
        to: String,
        subTitelTo: String,
        from: String,
        subTitelFrom: String,
        result: Double,
        exchangeUpDown: String
    ) {
        self.to = to
        self.subTitelTo = subTitelTo
        self.from = from
        self.subTitelFrom = subTitelFrom
        self.result = result
        self.exchangeUpDown = exchangeUpDown
    }
}


