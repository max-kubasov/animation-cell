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
    
    var labelMoreText: String? {
        didSet {
            text.text = labelMoreText
        }
    }
    
    var setImageForMoreInfoCell: UIImage? {
        didSet {
            imageView.image = setImageForMoreInfoCell
        }
    }
    
    var setBackgroundColor: UIColor? {
        didSet {
            containerView.backgroundColor = setBackgroundColor
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "121212"
        label.textColor = .white
        return label
    }()
    
    private var text: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.numberOfLines = 0
        text.textColor = .white
        text.text = "Sample text Sample text Sample text Sample text Sample text"
        return text
    }()
    
    private var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "paperplane.circle.fill"))
        return image
    }()
    
    private var containerView: UIView = {
        let containerView = UIView()
        // Add background color to the containerView
        containerView.backgroundColor = UIColor(hex: "FF0000")
        return containerView
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
        
        containerView.layer.cornerRadius = 20
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        

        
        // Constraints for containerView to fill the CustomView
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // Create UIImageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 150).isActive = true
        // Aspect ratio constraint to maintain image aspect ratio
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0).isActive = true
        containerView.addSubview(imageView)
        
        

        
        // Constraints for imageView
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        
        
//        // Create UILabel
//        label.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(label)
//        // Constraints for label
//        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
//        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        
        // Create and set constraints for text
        text.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(text)
        text.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        text.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        
    
    }
}

