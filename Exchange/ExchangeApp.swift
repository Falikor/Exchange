//
//  ExchangeApp.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import SwiftUI

@main
struct ExchangeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
