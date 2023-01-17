//
//  ExchangeTests.swift
//  ExchangeTests
//
//  Created by Бугреев Виктор Викторович on 17.01.2023.
//

import XCTest
@testable import Exchange

final class ExchangeTests: XCTestCase {

    var sut: ListEchangeViewModel!
    var interactor: ExchangeInteractorProtocol!
    var networkingStub: NetworkingStub!

    override func setUp() {
        super.setUp()
        networkingStub = NetworkingStub()
        interactor = ExchangeInteractorStub.init()
        sut = ListEchangeViewModel.init(interactor: interactor)
    }

    override func tearDown() {
        super.tearDown()
        networkingStub = nil
        interactor = nil
        sut = nil
    }
// TODO: Можно через кастомный scheduler но это долго писать
    func test_loadAllCurrency() {
        sut.loadAllCurrency()
        let exp = expectation(description: "Loaded all currencys")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertTrue(!sut.allCurrency.isEmpty)
    }

    func test_loadExchange_and_delete() {
        sut.loadAllCurrency()
        sut.loadExchange(to: "RUB", from: "EUR")
        let exp = expectation(description: "Loaded all exchange")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertTrue(!sut.echangeCoreModels.isEmpty)
        sut.echangeCoreModels.forEach {
            sut.delete($0)
        }
    }

    func test_networkingStub() {
        let interactor = ExchangeInteractor(networking: networkingStub)
        let sut = ListEchangeViewModel.init(interactor: interactor)
        sut.loadAllCurrency()
        XCTAssertTrue(networkingStub.count != 0)
    }
}
