//
//  AdsTableViewController.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 19/09/2021.
//

import UIKit

class AdsTableViewController: UITableViewController {

    enum State {
        case initial
        case data(ads: [ClassifiedAd], categories: [Category])
        case noData
        case error(error: Error)
    }

    enum Row {
        case ad(data: ClassifiedAd, category: Category?)
        case noData
    }

    private let cellId = "adCellId"

    var presenter: AdsPresenter?
    var rows: [Row] = []
    var state: State = .initial {
        didSet {
            switch state {
            case .initial:
                rows = [.noData]
            case .data(ads: let ads, categories: let cats):
                let adsSortedByDate = ads
                    .sorted(by: { $0.creationDate.compare($1.creationDate) == .orderedDescending })
                let urgentAds = adsSortedByDate.filter { $0.isUrgent }
                let normalAds = adsSortedByDate.filter { !$0.isUrgent }

                rows = Array(urgentAds + normalAds)
                    .map {
                        let categoryId = $0.categoryId
                        let category = cats.first(where: { $0.id == categoryId })
                        return Row.ad(data: $0, category: category)
                    }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if !ads.isEmpty {
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                }
            case .noData:
                rows = [.noData]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error:
                let alertController = UIAlertController(title: NSLocalizedString("error", comment: ""),
                                                        message: NSLocalizedString("error.fetching", comment: ""),
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("ads", comment: "")
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(AdListCell.self, forCellReuseIdentifier: cellId)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AdListCell else {
            return UITableViewCell()
        }

        let row = rows[indexPath.row]
        switch row {
        case .ad(data: let ad, category: let category):
            cell.titleLabel.text = ad.title
            cell.priceLabel.text = ad.price.formatToPrice()
            cell.categoryLabel.text = category?.name ?? ""
            cell.urgentLabel.isHidden = !ad.isUrgent
            cell.urgentBackground.isHidden = !ad.isUrgent
            if let urlString = ad.imagesUrl.small, let url = URL(string: urlString) {
                ImageCache.publicCache.load(url: url as NSURL, item: ad) { (fetchedItem, image) in
                    cell.adImageView.image = image
                }
            }
        case .noData:
            cell.titleLabel.text = NSLocalizedString("noAd", comment: "")
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        switch row {
        case .ad(data: let ad, category: _):
            presenter?.didSelect(ad: ad)
        case .noData:
            return
        }
    }

    @objc
    func didSelectCategoriesPicker() {
        presenter?.didSelectCategoriesPicker()
    }

}

extension AdsTableViewController {
    func displayCategoriesFilter(category: Category? = nil) {
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let categoryTitle: String = {
            if let category = category { return category.name }
            else {
                return NSLocalizedString("categories", comment: "")
            }
        }()
        let categoriesItem = UIBarButtonItem(title: categoryTitle,
                                             style: category == nil ? .plain : .done,
                                             target: self,
                                             action: #selector(didSelectCategoriesPicker))
        DispatchQueue.main.async {
            self.setToolbarItems([flexibleSpaceItem, categoriesItem], animated: true)
        }
    }

    func setPresenter(presenter: AdsPresenter) {
        self.presenter = presenter
    }

    func setAdsData(ads: [ClassifiedAd], categories: [Category]) {
        self.state = .data(ads: ads, categories: categories)
    }

    func showFetchingError(error: Error) {
        self.state = .error(error: error)
    }

    func showNoData() {
        self.state = .noData
    }
}
