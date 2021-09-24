//
//  AdListCell.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 22/09/2021.
//

import UIKit

class AdListCell: UITableViewCell {

    let adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .imagePlaceholder
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
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

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(adImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(adDataContainer)
        contentView.addSubview(secondRowContainer)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(urgentBackground)
        contentView.addSubview(urgentLabel)

        let margins = self.contentView.layoutMarginsGuide

        adImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        adImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        adImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        adImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true

        urgentLabel.topAnchor.constraint(equalTo: adImageView.topAnchor, constant: 9).isActive = true
        urgentLabel.leadingAnchor.constraint(equalTo: adImageView.leadingAnchor, constant: 12).isActive = true

        urgentBackground.topAnchor.constraint(equalTo: urgentLabel.topAnchor).isActive = true
        urgentBackground.leadingAnchor.constraint(equalTo: urgentLabel.leadingAnchor, constant: -3).isActive = true
        urgentBackground.bottomAnchor.constraint(equalTo: urgentLabel.bottomAnchor).isActive = true
        urgentBackground.trailingAnchor.constraint(equalTo: urgentLabel.trailingAnchor, constant: 3).isActive = true

        adDataContainer.leftAnchor.constraint(equalTo: adImageView.leftAnchor).isActive = true
        adDataContainer.topAnchor.constraint(equalTo: adImageView.bottomAnchor, constant: 8).isActive = true
        adDataContainer.rightAnchor.constraint(equalTo: adImageView.rightAnchor).isActive = true

        secondRowContainer.addArrangedSubview(categoryLabel)
        secondRowContainer.addArrangedSubview(priceLabel)

        adDataContainer.addArrangedSubview(titleLabel)
        adDataContainer.addArrangedSubview(secondRowContainer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        adImageView.image = nil
    }
}
