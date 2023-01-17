//
//  CoreDataManager.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistenContainer: NSPersistentContainer
    static let shared = CoreDataManager()

    var viewContext: NSManagedObjectContext {
        return persistenContainer.viewContext
    }

    func getExchangeModelCoreById(id: NSManagedObjectID) -> ExchangeModelCore? {
        do {
            return try viewContext.existingObject(with: id) as? ExchangeModelCore
        } catch {
            return nil
        }
    }

    func update(id: NSManagedObjectID, result: Double) {
        let objict = try? viewContext.existingObject(with: id) as? ExchangeModelCore
        guard let oldValue = objict?.result else { return }
        if oldValue > result {
            objict?.exchangeUpDown = ExchangeUpDown.red.rawValue
        } else if oldValue == result {
            objict?.exchangeUpDown = ExchangeUpDown.blue.rawValue
        } else {
            objict?.exchangeUpDown = ExchangeUpDown.green.rawValue
        }
        objict?.result = result
        save()
    }

    func deleteExchangeModelCore(item: ExchangeModelCore) {
        viewContext.delete(item)
        save()
    }

    func getAllExchangeModelCore() -> [ExchangeModelCore] {
        let reqest: NSFetchRequest<ExchangeModelCore> = ExchangeModelCore.fetchRequest()

        do {
            return try viewContext.fetch(reqest)
        } catch {
            return []
        }
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }

    private init() {
        persistenContainer = NSPersistentContainer(name: "Exchange")
        persistenContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError()
            }
        }
    }
}
