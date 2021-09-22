//
//  CategoriesPresenter.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 22/09/2021.
//

import Foundation

class CategoriesPresenter {

    weak var viewController: CategoriesTableViewController?
    var coordinator: AppCoordinator
    var document: Document

    init(coordinator: AppCoordinator, viewController: CategoriesTableViewController, document: Document) {
        self.coordinator = coordinator
        self.viewController = viewController
        self.document = document
    }

    func didSelectCategory(category: Category?) {
        coordinator.filterByCategory(category: category)
        viewController?.dismiss(animated: true, completion: nil)
    }

}
