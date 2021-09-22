//
//  CategoriesTableViewController.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 22/09/2021.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    var categories: [Category?]

    private var presenter: CategoriesPresenter?

    private let cellId = "categoryCellId"

    init(categories: [Category]) {
        self.categories = categories
        self.categories.insert(nil, at: 0)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Catégories"
        self.navigationItem.setRightBarButtonItems(
            [UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissSelf))],
            animated: true
        )
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    @objc
    private func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let category = categories[indexPath.row]
        let rowTitle: String = {
            if let category = category { return category.name } else { return "Toutes" }
        }()
        cell.textLabel?.text = rowTitle
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        presenter?.didSelectCategory(category: selectedCategory)
    }

}

extension CategoriesTableViewController {
    func setPresenter(presenter: CategoriesPresenter) {
        self.presenter = presenter
    }
}
