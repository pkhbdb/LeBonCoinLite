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

        fetchData()
    }

    private func fetchData() {
        let dispatchQueue = DispatchQueue(label: "adsFetchingSerialQueue")
        let group = DispatchGroup()
        group.enter()
        dispatchQueue.async {
            self.document.fetchClassifiedAds { adsFetchingResult in
                switch adsFetchingResult {
                case .success(let ads):
                    self.allAds = ads
                case .failure(let error):
                    self.viewController?.showFetchingError(error: error)
                }
                group.leave()
            }
        }
        dispatchQueue.async {
            group.wait()
            group.enter()
            self.document.fetchCategories { categoriesFetchingResult in
                switch categoriesFetchingResult {
                case .success(let categories):
                    self.allCategories = categories
                    self.viewController?.setAdsData(ads: self.allAds, categories: categories)
                    self.viewController?.displayCategoriesFilter()
                case .failure(let error):
                    self.viewController?.showFetchingError(error: error)
                }
                group.leave()
            }
        }
    }

    func didSelect(ad: ClassifiedAd) {
        let category = allCategories.first(where: { $0.id == ad.categoryId })
        coordinator.showAdDetail(ad: ad, category: category)
    }

    func didSelectCategoriesPicker() {
        coordinator.showCategoryPicker(categories: allCategories)
    }

    func filter(by category: Category?) {
        if let category = category {
            self.viewController?.setAdsData(ads: allAds.filter { $0.categoryId == category.id },
                                            categories: allCategories)
        } else {
            self.viewController?.setAdsData(ads: allAds,
                                            categories: allCategories)
        }
        self.viewController?.displayCategoriesFilter(category: category)
    }

}
