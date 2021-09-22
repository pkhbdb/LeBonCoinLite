//
//  AdsPresenter.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 21/09/2021.
//

import Foundation

class AdsPresenter {

    weak var viewController: AdsTableViewController?
    var coordinator: AppCoordinator
    var document: Document

    var allAds = [ClassifiedAd]()
    var allCategories = [Category]()

    init(coordinator: AppCoordinator, viewController: AdsTableViewController, document: Document) {
        self.coordinator = coordinator
        self.viewController = viewController
        self.document = document
    }

    func fetchAds() {
        document.fetchClassifiedAds { adsFetchingResult in
            switch adsFetchingResult {
            case .success(let ads):
                self.allAds = ads
                self.viewController?.setAds(ads: ads)
            case .failure(let error):
                self.viewController?.showFetchingError(error: error)
            }
        }
    }

    func fetchCategories() {
        document.fetchCategories { categoriesFetchingResult in
            switch categoriesFetchingResult {
            case .success(let categories):
                self.allCategories = categories
                self.viewController?.displayCategoriesFilter()
            case .failure(let error):
                self.viewController?.showFetchingError(error: error)
            }
        }
    }

    func didSelect(ad: ClassifiedAd) {
        coordinator.showAdDetail(ad: ad)
    }

    func didSelectCategoriesPicker() {
        coordinator.showCategoryPicker(categories: allCategories)
    }

    func filter(by category: Category?) {
        if let category = category {
            self.viewController?.setAds(ads: allAds.filter { $0.categoryId == category.id })
        } else {
            self.viewController?.setAds(ads: allAds)
        }
    }

}
