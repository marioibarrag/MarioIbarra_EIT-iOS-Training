import UIKit

class RestaurantCell: UICollectionViewCell {
    
    static let id = "RestaurantCell"
    
    private var gradienteImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cellGradientBackground")
        return imageView
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
     
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemPink
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubview(imageView)
        imageView.addSubview(gradienteImgView)
        gradienteImgView.addSubview(nameLabel)
        gradienteImgView.addSubview(categoryLabel)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        gradienteImgView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        gradienteImgView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        gradienteImgView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        gradienteImgView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
    }
    
    func configureCell(restaurantName: String, category: String, imgData: Data) {
        nameLabel.text = restaurantName
        categoryLabel.text = category
        imageView.image = UIImage(data: imgData)
    }
}
