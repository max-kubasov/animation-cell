//
//  MoreInfoViewController.swift
//  AnimationCell
//
//  Created by Max on 26.02.2024.
//

import UIKit

class MoreInfoViewController: UIViewController {
    
    var labelText: String?
    var imageUrl: String?
    var id: String?
    
    struct Item: Codable {
        let id: String
        let text: String
    }
    
    var array = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = labelText
        
        setupNavBarVC()
        
        setupCustomView()
    }
    
    @objc func backButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    func setupNavBarVC() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationController?.navigationBar.backgroundColor = .red
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
    }
    
    func setupCustomView() {
        let customView = MoreInfoView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.labelText = labelText
        view.addSubview(customView)
        
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customView.heightAnchor.constraint(equalToConstant: 200) // Set your desired height
        ])
    }
    
}
