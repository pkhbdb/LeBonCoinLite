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
        self.rootNavigationController.navigationBar.prefersLargeTitles = true
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

    func showAdDetail(ad: ClassifiedAd) {
        let adDetailViewController = AdDetailViewController(ad: ad)
        self.rootNavigationController.pushViewController(adDetailViewController, animated: true)
    }
}
