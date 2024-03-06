//
//  MoreInfoView.swift
//  AnimationCell
//
//  Created by Max on 01.03.2024.
//

import UIKit

class MoreInfoView: UIView {
    
    var labelText: String? {
        didSet {
            label.text = labelText
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "121212"
        return label
    }()
    
    private var text: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.numberOfLines = 0
        text.text = "Sample text Sample text Sample text Sample text Sample text"
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        // Create UIView to contain image and text
        let containerView = UIView()
        containerView.layer.cornerRadius = 20
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        // Add background color to the containerView
        containerView.backgroundColor = UIColor.lightGray
        
        // Constraints for containerView to fill the CustomView
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // Create UIImageView
        let imageView = UIImageView(image: UIImage(named: "yourImageName")) // Set your image here
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        // Create UILabel
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        
        // Constraints for imageView
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        
        // Constraints for label
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        
        // Create and set constraints for text
        text.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(text)
        //text.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        text.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        text.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        text.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
    
    }
}

