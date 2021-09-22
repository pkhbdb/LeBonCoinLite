//
//  CategoriesTableViewController.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 22/09/2021.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    let categories: [Category]

    private var presenter: CategoriesPresenter?

    private let cellId = "categoryCellId"

    init(categories: [Category]) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
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
        cell.textLabel?.text = category.name
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
