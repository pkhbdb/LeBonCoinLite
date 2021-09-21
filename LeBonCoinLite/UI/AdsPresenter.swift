//
//  AdsPresenter.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 21/09/2021.
//

import Foundation
import UIKit

class AdsPresenter {

    weak var viewController: AdsTableViewController?
    var coordinator: AppCoordinator
    var document: Document

    init(coordinator: AppCoordinator, viewController: AdsTableViewController, document: Document) {
        self.coordinator = coordinator
        self.viewController = viewController
        self.document = document
    }

    func fetchAds() {
        document.fetchClassifiedAds { adsFetchingResult in
            switch adsFetchingResult {
            case .success(let ads):
                self.viewController?.setAds(ads: ads)
            case .failure(let error):
                self.viewController?.showFetchingError(error: error)
            }
        }
    }

}
