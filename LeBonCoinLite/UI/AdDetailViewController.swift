//
//  AdDetailViewController.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 21/09/2021.
//

import UIKit

class AdDetailViewController: UIViewController {

    let ad: ClassifiedAd

    init(ad: ClassifiedAd) {
        self.ad = ad
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        print(ad.title)
        print(ad.creationDate)
    }

}
