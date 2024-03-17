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
    var text: String?
    let customView = MoreInfoView()
    var image = UIImage()
    
    struct Item: Codable {
        let id: String
        let text: String
    }
    
    var data: Item?
    
    var array = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = labelText
        
        parseJSON()
        
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
        
        print("START setupCustomView")
        
        customView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(customView)
        
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customView.heightAnchor.constraint(equalToConstant: 200) // Set your desired height
        ])
    }
    
    func parseJSON() {
        
        print("START JSON")
        
        let fullTextUrl = "https://test-task-server.mediolanum.f17y.com/texts/" + id!
        
        guard let url = URL(string: fullTextUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            print("=1=1=1=1=1=1=1")
            
            guard let data = data, error == nil else { return }
            
            do {
                
                self.data = try JSONDecoder().decode(Item.self, from: data)
                
                print("+++++++")
                print("\(data)")
                
                self.text = self.data?.text
                
                print("=2=2=2=2=121=2")
                print("\(self.text ?? "")")
                
                DispatchQueue.main.async {
                    self.customView.labelText = self.labelText
                    self.customView.labelMoreText = self.text
                    self.customView.setImageForMoreInfoCell = self.image
                }

                
                
            } catch {
                print("Error \(error)")
            }
        }.resume()
        
        print("FULL TEXT URL ----- \(fullTextUrl)")
    }
    
}
