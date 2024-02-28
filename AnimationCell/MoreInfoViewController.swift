//
//  MoreInfoViewController.swift
//  AnimationCell
//
//  Created by Max on 26.02.2024.
//

import UIKit

class MoreInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "More Info VC"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))

        view.backgroundColor = .white
    }
    
    @objc func backButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
}
