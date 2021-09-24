//
//  AdDetailPresenter.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 21/09/2021.
//

import Foundation

class AdDetailPresenter {

    weak var viewController: AdDetailViewController?
    var coordinator: AppCoordinator
    var document: Document

    init(coordinator: AppCoordinator, viewController: AdDetailViewController, document: Document) {
        self.coordinator = coordinator
        self.viewController = viewController
        self.document = document
    }
}
