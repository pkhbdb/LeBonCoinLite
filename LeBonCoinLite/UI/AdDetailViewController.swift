//
//  AdDetailViewController.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 21/09/2021.
//

import UIKit

class AdDetailViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(named: "imagePlaceholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let adDataContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let secondRowContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let urgentBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .urgentBadge
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let urgentLabel: UILabel = {
        let label = UILabel()
        label.text = "URGENT"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var presenter: AdDetailPresenter?

    let ad: ClassifiedAd
    let category: Category?

    init(ad: ClassifiedAd, category: Category?) {
        self.ad = ad
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let urlString = ad.imagesUrl.small, let url = URL(string: urlString) {
            ImageCache.publicCache.load(url: url as NSURL, item: ad) { (fetchedItem, image) in
                self.adImageView.image = image
            }
        }

        if #available(iOS 13, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }

        self.title = category?.name ?? ""

        titleLabel.text = ad.title
        priceLabel.text = ad.price.formatToPrice()

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateLabel.text = dateFormatter.string(from: ad.creationDate)
        descriptionLabel.text = ad.description

        urgentBackground.isHidden = !ad.isUrgent
        urgentLabel.isHidden = !ad.isUrgent

        setupConstraints()
    }

    private func setupConstraints() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(adImageView)
        scrollView.addSubview(adDataContainer)
        scrollView.addSubview(secondRowContainer)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(urgentBackground)
        scrollView.addSubview(urgentLabel)

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        adImageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        adImageView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor).isActive = true
        adImageView.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor).isActive = true

        urgentLabel.topAnchor.constraint(equalTo: adImageView.topAnchor, constant: 9).isActive = true
        urgentLabel.leadingAnchor.constraint(equalTo: adImageView.leadingAnchor, constant: 12).isActive = true

        urgentBackground.topAnchor.constraint(equalTo: urgentLabel.topAnchor).isActive = true
        urgentBackground.leadingAnchor.constraint(equalTo: urgentLabel.leadingAnchor, constant: -3).isActive = true
        urgentBackground.bottomAnchor.constraint(equalTo: urgentLabel.bottomAnchor).isActive = true
        urgentBackground.trailingAnchor.constraint(equalTo: urgentLabel.trailingAnchor, constant: 3).isActive = true

        adDataContainer.leftAnchor.constraint(equalTo: adImageView.leftAnchor, constant: 16).isActive = true
        adDataContainer.topAnchor.constraint(equalTo: adImageView.bottomAnchor, constant: 16).isActive = true
        adDataContainer.rightAnchor.constraint(equalTo: adImageView.rightAnchor, constant: -16).isActive = true
        adDataContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true

        secondRowContainer.addArrangedSubview(dateLabel)
        secondRowContainer.addArrangedSubview(priceLabel)

        adDataContainer.addArrangedSubview(titleLabel)
        adDataContainer.addArrangedSubview(secondRowContainer)
        adDataContainer.addArrangedSubview(descriptionLabel)
    }

}

extension AdDetailViewController {
    func setPresenter(presenter: AdDetailPresenter) {
        self.presenter = presenter
    }
}
