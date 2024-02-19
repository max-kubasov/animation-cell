// iOs Test cell: image, text, rectangle background color


import UIKit

class ViewController: UITableViewController {

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
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
     
        setupTableView()
        
        fetchData()
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
                
                print("DATA(ApiResponse)-------------\(self.data)")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func setupNavBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)

        let navItem = UINavigationItem(title: "SomeTitle")

        navBar.setItems([navItem], animated: false)
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        // Add constraints to position the table view below the navigation bar
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
                    } else {
                        
                        print("Error load image")
                    }
                }
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
