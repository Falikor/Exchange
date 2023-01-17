//
//  EchangeVieModel.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 17.01.2023.
//

import Foundation
import CoreData
import SwiftUI

// TODO: плохой неминг взят из json
struct EchangeVieModel: Equatable, Hashable {
    let exchangeModelCore: ExchangeModelCore
    var id: NSManagedObjectID {
        return exchangeModelCore.objectID
    }
    var to: String {
        return exchangeModelCore.to ?? ""
    }
    var subTitelTo: String {
        return exchangeModelCore.subTitelTo ?? ""
    }
    var from: String {
        return exchangeModelCore.from ?? ""
    }
    var subTitelFrom: String {
        return exchangeModelCore.subTitelFrom ?? ""
    }
    var result: Double {
        return exchangeModelCore.result
    }
    var exchangeUpDown: String {
        return exchangeModelCore.exchangeUpDown ?? ""
    }
}

enum ExchangeUpDown: String, CaseIterable {
    case red, green, blue

    var wrappedValue: Color {
        switch self {
        case .red: return Color.red
        case .blue: return Color.blue
        case .green: return Color.green
        }
    }
}
