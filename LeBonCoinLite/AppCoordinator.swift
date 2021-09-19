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
        self.rootNavigationController.setViewControllers([AdsListTableTableViewController(document: self.document)],
                                                         animated: false)
        self.window.rootViewController = self.rootNavigationController
    }

    func start() {
        self.window.makeKeyAndVisible()
        self.rootNavigationController.isToolbarHidden = false
    }
}
