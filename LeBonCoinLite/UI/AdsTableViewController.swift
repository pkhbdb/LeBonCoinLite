//
//  AdsTableViewController.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 19/09/2021.
//

import UIKit

protocol AdsListProtocol {
    func setPresenter(presenter: AdsPresenter)
    func setAds(ads: [ClassifiedAd])
    func showFetchingError(error: Error)
    func showNoData()
}

class AdsTableViewController: UITableViewController {

    enum State {
        case initial
        case data(ads: [ClassifiedAd])
        case noData
        case error(error: Error)
    }

    enum Row {
        case ad(data: ClassifiedAd)
        case noData
    }

    private let cellId = "adCellId"

    private var presenter: AdsPresenter?
    var rows: [Row] = []
    var state: State = .initial {
        didSet {
            switch state {
            case .initial:
                rows = [.noData]
            case .data(ads: let ads):
                let adsSortedByDate = ads
                    .sorted(by: { $0.creationDate.compare($1.creationDate) == .orderedDescending })
                let urgentAds = adsSortedByDate.filter { $0.isUrgent }
                let normalAds = adsSortedByDate.filter { !$0.isUrgent }

                rows = Array(urgentAds + normalAds)
                    .map { return Row.ad(data: $0) }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .noData:
                rows = [.noData]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error:
                let alertController = UIAlertController(title: "Error",
                                                        message: "An error occured while fetching ads. Please try again later",
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
        self.title = "Annonces"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        presenter?.fetchAds()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let row = rows[indexPath.row]
        switch row {
        case .ad(data: let ad):
            cell.textLabel?.text = (ad.isUrgent ? "U " : "") + "\(ad.title)"
        case .noData:
            cell.textLabel?.text = "No data"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        switch row {
        case .ad(data: let ad):
            presenter?.didSelectAd(ad: ad)
        case .noData:
            return
        }
    }

}

extension AdsTableViewController: AdsListProtocol {
    func setPresenter(presenter: AdsPresenter) {
        self.presenter = presenter
    }

    func setAds(ads: [ClassifiedAd]) {
        self.state = .data(ads: ads)
    }

    func showFetchingError(error: Error) {
        self.state = .error(error: error)
    }

    func showNoData() {
        self.state = .noData
    }
}
