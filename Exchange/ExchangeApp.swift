//
//  ExchangeApp.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import SwiftUI

@main
struct ExchangeApp: App {
    let echangeFactory = EchangeFactory(networking: Networking())
    var body: some Scene {
        WindowGroup {
            echangeFactory.createListEchangeView()
        }
    }
}
