//
//  AppCoordinator.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 19/09/2021.
//

import UIKit
import Foundation

protocol Coordinator {
    var rootNavigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var rootNavigationController: UINavigationController

    private let window: UIWindow

    var document: Document

    public init(window: UIWindow) {
        self.window = window
        self.document = Document()
        self.rootNavigationController = UINavigationController()
        self.window.rootViewController = self.rootNavigationController
    }

    func start() {
        self.rootNavigationController.isToolbarHidden = false

        let adsTableViewController = AdsTableViewController()
        let adsPresenter = AdsPresenter(coordinator: self,
                                        viewController: adsTableViewController,
                                        document: document)
        adsTableViewController.setPresenter(presenter: adsPresenter)
        self.rootNavigationController.setViewControllers([adsTableViewController],
                                                         animated: false)
        self.window.makeKeyAndVisible()
    }

    func showAdDetail(ad: ClassifiedAd, category: Category?) {
        let adDetailViewController = AdDetailViewController(ad: ad, category: category)
        let adDetailPresenter = AdDetailPresenter(coordinator: self,
                                                  viewController: adDetailViewController,
                                                  document: document)
        adDetailViewController.setPresenter(presenter: adDetailPresenter)
        self.rootNavigationController.pushViewController(adDetailViewController, animated: true)
    }

    func showCategoryPicker(categories: [Category]) {
        let navigationController = UINavigationController()
        let categoriesTableViewController = CategoriesTableViewController(categories: categories)
        let presenter = CategoriesPresenter(coordinator: self,
                                            viewController: categoriesTableViewController,
                                            document: document)
        categoriesTableViewController.setPresenter(presenter: presenter)
        navigationController.setViewControllers([categoriesTableViewController], animated: true)
        self.rootNavigationController.present(navigationController,
                                              animated: true,
                                              completion: nil)
    }

    func filterByCategory(category: Category?) {
        guard let adsTVC = self.rootNavigationController.viewControllers
            .first(where: { $0.isKind(of: AdsTableViewController.self) }) as? AdsTableViewController else {
            return
        }

        adsTVC.presenter?.filter(by: category)
    }
}
