//
//  ListEchangeViewModel.swift
//  Exchange
//
//  Created by Бугреев Виктор Викторович on 16.01.2023.
//

import Foundation
import Combine
import CoreData
import UIKit
import SwiftUI

class ListEchangeViewModel: ObservableObject {
    @Published var echangeCoreModels: [EchangeVieModel] = []
    @Published var allCurrency: [String: String] = [:]
    @Published var selectToCurrency: String = ""
    @Published var selectFromCurrency: String = ""
    @Published var currencyBottomSheetPresentes: Bool = false
    
    var timer = Timer()
    let interactor: ExchangeInteractorProtocol
    private var disposable = Set<AnyCancellable>()

    init(
        interactor: ExchangeInteractorProtocol
    ) {
        self.interactor = interactor
        loadAllCurrency()
        getAllExchangeModelCore()
        update()
    }

    func update() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { _ in
            self.echangeCoreModels.forEach {
                self.loadExchange(to: $0.to, from: $0.from, updateId: $0.id)
            }
        })
    }

    func getAllExchangeModelCore() {
        echangeCoreModels = CoreDataManager.shared.getAllExchangeModelCore().map(EchangeVieModel.init)
    }

    func delete(_ iteam: EchangeVieModel) {
        let echangeCoreModel = CoreDataManager.shared.getExchangeModelCoreById(id: iteam.id)
        if let echangeCoreModel = echangeCoreModel {
            CoreDataManager.shared.deleteExchangeModelCore(item: echangeCoreModel)
        }
    }

    func checkForDuplicate(to: String, from: String) -> Bool {
        var check = false
        guard !to.isEmpty || !from.isEmpty else { return true}
        echangeCoreModels.forEach {
            if $0.from == from && $0.to == to {
                check = true
            }
        }
        return check
    }

    func loadExchange(to: String, from: String, updateId: NSManagedObjectID? = nil) {
        if updateId == nil {
            guard checkForDuplicate(to: to, from: from) == false else { return }
        }
        interactor.echange(to: to, from: from)?
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] result in
                guard let self = self else {
                    return
                }
                guard let to = result.query?.to else { return }
                guard let from = result.query?.from else { return }
                guard let result = result.result else { return }
                // update coreData
                if let id = updateId {
                    CoreDataManager.shared.update(id: id, result: result)
                } else {
                    let echangeCoreModel = ExchangeModelCore(context: CoreDataManager.shared.viewContext)
                    echangeCoreModel.to = to
                    echangeCoreModel.subTitelTo = self.allCurrency[to]
                    echangeCoreModel.from = from
                    echangeCoreModel.subTitelFrom = self.allCurrency[from]
                    echangeCoreModel.result = result
                    echangeCoreModel.exchangeUpDown = ExchangeUpDown.blue.rawValue
                    CoreDataManager.shared.save()
                }
                self.getAllExchangeModelCore()
            }
            .store(in: &disposable)

    }
    func showCurrencySelectionSheet() {
        currencyBottomSheetPresentes = true
    }
    func loadAllCurrency() {
        interactor.allCurrency()?
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] result in
                guard let self = self else {
                    return
                }
                guard let symbols = result.symbols else { return }
                self.allCurrency = symbols
            }
            .store(in: &disposable)
    }

}

