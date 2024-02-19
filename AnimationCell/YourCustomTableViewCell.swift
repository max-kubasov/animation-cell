//
//  YourCustomTableViewCell.swift
//  AnimationCell
//
//  Created by Max on 15.01.2024.
//

import UIKit


class YourCustomTableViewCell: UITableViewCell {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit // Adjust this based on your design
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(colorView)
        contentView.addSubview(itemImageView)

        // Add constraints as needed
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            colorView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            colorView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 20),
            colorView.heightAnchor.constraint(equalToConstant: 20),
            itemImageView.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 8),
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 50), // Adjust this based on your design
            itemImageView.heightAnchor.constraint(equalToConstant: 50), // Adjust this based on your design
        ])
    }
    
}

