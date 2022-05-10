import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController {
    
    private var annotation = MKPointAnnotation()

    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: .zero)//CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 500)))
        map.translatesAutoresizingMaskIntoConstraints = false
        map.mapType = .standard
        map.isZoomEnabled = true
        return map
    }()
    
    private var firstUIView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = UIColor(red: 52 / 255, green: 179 / 255, blue: 121 / 255, alpha: 1)
        return uiView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.numberOfLines = 3
        label.textColor = Constants.darkGrayColor
        return label
    }()
    
    private var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.numberOfLines = 1
        label.textColor = Constants.darkGrayColor
        return label
    }()
    
    private var twitterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.numberOfLines = 1
        label.textColor = Constants.darkGrayColor
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        title = "Lunch Tyme"
    }
    
    func setUp() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        view.addSubview(firstUIView)
        firstUIView.addSubview(nameLabel)
        firstUIView.addSubview(categoryLabel)
        view.addSubview(addressLabel)
        view.addSubview(phoneLabel)
        view.addSubview(twitterLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        mapView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        mapView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        firstUIView.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        firstUIView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        firstUIView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        firstUIView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: firstUIView.centerYAnchor).isActive = true

        categoryLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: firstUIView.centerYAnchor).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: firstUIView.bottomAnchor, constant: 16).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12).isActive = true
        
        phoneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 26).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12).isActive = true
        
        twitterLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 26).isActive = true
        twitterLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12).isActive = true
        
    }

    func configDetailsVC(lat: Double, lng: Double, restaurant: Restaurant) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 100, longitudinalMeters: 100);
        let adjustedRegion = mapView.regionThatFits(viewRegion)
        mapView.setRegion(adjustedRegion, animated: true)
        annotation.coordinate = location
        annotation.title = restaurant.name
        mapView.addAnnotation(annotation)
        
        nameLabel.text = restaurant.name
        categoryLabel.text = restaurant.category
        if let location = restaurant.location {
            if let formattedAddress = location.formattedAddress {
                addressLabel.text = "\(formattedAddress[0])\n\(formattedAddress[1])\n\(formattedAddress[2])"
            }
        }
        
        if let contact = restaurant.contact {
            if let phone = contact.formattedPhone {
                phoneLabel.text = phone
            }
            
            if let twitter = contact.twitter {
                twitterLabel.text = "Twitter: @\(twitter)"
            }
        }
        
    }
}
