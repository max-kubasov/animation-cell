//
//  CustomTableViewCell.swift
//  AnimationCell
//
//  Created by Max on 15.01.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    // Create UI elements
    let customRectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue // Set your desired background color
        view.layer.cornerRadius = 10 // Set corner radius for a rounded rectangle
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // Set your desired content mode
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // Set your image, you can replace "yourImageName" with your actual image name
        imageView.image = UIImage(named: "yourImageName")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white // Set your desired text color
        // Set your text for the label
        label.text = "Your Label Text"
        label.font = UIFont.systemFont(ofSize: 27)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews to the cell's content view
        contentView.addSubview(customRectangleView)
        customRectangleView.addSubview(itemImageView)
        customRectangleView.addSubview(nameLabel)

        // Configure constraints
        NSLayoutConstraint.activate([
            // Rectangle constraints
            customRectangleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            customRectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            customRectangleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            customRectangleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            customRectangleView.heightAnchor.constraint(equalToConstant: 100),
            
            // Image view constraints
            itemImageView.topAnchor.constraint(equalTo: customRectangleView.topAnchor, constant: 5),
            itemImageView.trailingAnchor.constraint(equalTo: customRectangleView.trailingAnchor, constant: -5),
            itemImageView.bottomAnchor.constraint(equalTo: customRectangleView.bottomAnchor, constant: -5),
            itemImageView.widthAnchor.constraint(equalToConstant: 90), // Set your desired width
            
            // Label constraints
            nameLabel.centerYAnchor.constraint(equalTo: customRectangleView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: customRectangleView.leadingAnchor, constant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

