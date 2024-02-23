// iOs Test cell: image, text, rectangle background color


import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    var navBar: UINavigationBar!
    let imageView = UIImageView()
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    var isAnimationRunning = true
    var emptyStateLabel = UILabel()

    struct Item: Codable {
        let id: String
        let name: String
        let image: String?
        let color: String
    }

    struct ApiResponse: Codable {
        let title: String
        let items: [Item]
    }

    var data: ApiResponse?
    
    var array = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        setupTableView()
        
        setupImageLoader()
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
    }

    func fetchData() {
        guard let url = URL(string: "https://test-task-server.mediolanum.f17y.com/items/random") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }

            do {
                self.data = try JSONDecoder().decode(ApiResponse.self, from: data)

                self.array = self.data!.items
                
                print("ARRAY(ITEMS)-----------\(self.array)")
                
                print("DATA(ApiResponse)-------------\(self.data!)")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.errorReceiveData()
            }
        }.resume()
    }
    
    func setupNavBar() {
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        navBar.backgroundColor = .red
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "SomeTitle")
        
        // Create custom button
        let customButton = UIButton(type: .system)
        let customImage = UIImage(systemName: "arrow.triangle.2.circlepath")
        customButton.setImage(customImage, for: .normal)
        customButton.tintColor = .white
        
        
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        customButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        customButton.addTarget(self, action: #selector(updateFruit), for: .touchUpInside)
        
        let customBarButtonItem = UIBarButtonItem(customView: customButton)
        
        navItem.rightBarButtonItem = customBarButtonItem
        
        navBar.setItems([navItem], animated: false)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
    }
    
    func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        // Add constraints to position the table view below the navigation bar
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    @objc func updateFruit() {
        print("Update Fruit")

        
        DispatchQueue.main.async {
            self.array.removeAll()
            self.data = nil
            self.tableView.reloadData()
        }
        
        
        DispatchQueue.main.async {
            self.emptyStateLabel.text = ""
        }
        
        
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
        
        startAnimation()
        
        print("ARRAY--------------\(array)")
        print("2222222------------\(data?.items.count)")
        
        

        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchData()
            self.stopAnimation()
        }
        
        
    }
    
    func setupImageLoader() {
        
        if let image = UIImage(named: "loader") {
            imageView.image = image
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        rotateImage()
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func rotateImage() {
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Float.pi * 2
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.duration = 1.0

        // Apply the animation to the image view's layer
        imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func startAnimation() {
        imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        print("START ANIMATION")
        imageView.isHidden = false
        isAnimationRunning = true
        
    }

    func stopAnimation() {
        imageView.layer.removeAnimation(forKey: "rotationAnimation")
        print("STOP ANIMATION")
        imageView.isHidden = true
        isAnimationRunning = false
    }
    
    func errorReceiveData() {
        print("----------ERROR--------------")
        DispatchQueue.main.async {
            if self.array.isEmpty {
                // Create a custom view for the empty state
                self.emptyStateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
                self.emptyStateLabel.text = "No items to display"
                self.emptyStateLabel.textAlignment = .center
                self.emptyStateLabel.textColor = .gray
                
                // Set the custom view as the background view of the table view
                self.tableView.backgroundView = self.emptyStateLabel
            } else {
                // If there are items, remove the background view
                self.tableView.backgroundView = nil
            }
        }
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        if let item = data?.items[indexPath.row] {
            cell.nameLabel.text = item.name
            cell.customRectangleView.backgroundColor = UIColor(hex: item.color)
            
            if let imageUrl = item.image {
                let fullImageUrl = "https://test-task-server.mediolanum.f17y.com" + imageUrl
                print("FULL IMAGE URL ------ \(fullImageUrl)")
                ImageLoaderManager.shared.loadImage(from: URL(string: fullImageUrl)!) { image in
                    
                    if let image = image {
                        
                        DispatchQueue.main.async {
                            cell.itemImageView.image = image
                        }
                        
                        print("ShowImage")
                        print("IMAGE ------- \(image)")
                        
                    } else {
                        print("Error load image")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    cell.itemImageView.image = nil
                }
                print("------------Image is empty------------")
            }
        }
        
        return cell
    }


}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }
}
