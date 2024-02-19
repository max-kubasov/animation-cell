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

        tableView.register(YourCustomTableViewCell.self, forCellReuseIdentifier: "YourCustomCellIdentifier")
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        if indexPath.row % 2 == 0 {
//            cell.backgroundColor = .darkGray
//        } else {
//            cell.backgroundColor = .lightGray
//        }
        
//        if let item = data?.items[indexPath.row] {
//            cell.backgroundColor = UIColor(hex: item.color)
//        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell

        if let item = data?.items[indexPath.row] {
            cell.nameLabel.text = item.name
//            cell.colorView.backgroundColor = UIColor(hex: item.color)
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
//                cell.itemImageView.load(url: URL(string: fullImageUrl)!)
            }
        }

        return cell
    }

}



//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                        print("!!!!!!!!!------------00000000000000")
//                    }
//                }
//            }
//        }
//    }
//}

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
