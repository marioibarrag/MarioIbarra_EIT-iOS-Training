//
import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 65
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        return tableView
    }()
    
    var photos = Photo(photos: [])
    var lastIndex = 0
    
    var statusArr: [Bool] = []
    
    let detailViewController = DetailViewController()
    let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=Q9YNbzmt8C5OpY7L3MV4DHJhrdIGCbjx3tVWxRcf&sol=2000&page=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        title = "NASA Photos"
        view.addSubview(tableView)
        tableView.pin(to: view)
        detailViewController.delegate = self
        
        
        
    }
    
    func fetchData() {
        guard let url = URL(string: url) else {
            print("<----- BAD URL ----->")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("<----- ERROR IN API CALL ----->")
                print(error.localizedDescription)
                return
            }
            
            if let data = data {
                do {
                    print("Calling api:\n\(url)")
                    self.photos = try JSONDecoder().decode(Photo.self, from: data)
                } catch {
                    print("<----- BAD DECODE ----->")
                }
            }
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.statusArr = UserDefaults.standard.array(forKey: "statusArr") as? [Bool] ?? Array(repeating: false, count: self?.photos.photos.count ?? 0)
            }
        }.resume()
        
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arr = UserDefaults.standard.array(forKey: "statusArr") as? [Bool] ?? statusArr
        let row = indexPath.row
        let id = photos.photos[row].id
        let status = arr[row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.setLabelsText(photoId: id, status: (status) ? "true" : "false")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arr = UserDefaults.standard.object(forKey: "statusArr") as? [Bool] ?? statusArr
        lastIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        var image = UIImage()
        var imgUrl = photos.photos[indexPath.row].img_src
        imgUrl.insert("s", at: imgUrl.index(imgUrl.startIndex, offsetBy: 4))
        let url = URL(string: imgUrl)
        
        if let data = try? Data(contentsOf: url!) {
            image = UIImage(data: data)!
        }
        detailViewController.setImage(image: image)
        detailViewController.sw.setOn(arr[indexPath.row], animated: false)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

extension ViewController: DetailVCDelegate {
    func didToggleSwitch(status: Bool) {
        statusArr[lastIndex] = status
        print(statusArr)
        UserDefaults.standard.set(statusArr, forKey: "statusArr")
        photos.photos[lastIndex].status = status
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
}
