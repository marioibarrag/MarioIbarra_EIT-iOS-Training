import UIKit

protocol DetailVCDelegate: AnyObject {
    func didToggleSwitch(status: Bool)
}

class DetailViewController: UIViewController {

    weak var delegate: DetailVCDelegate?
    
    lazy var sw = UISwitch()
    
    private var imageView = UIImageView()
    
    lazy private var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Detail"
        view.backgroundColor = .white
        setUpUI()
    }
    
    func setUpUI() {
        view.addSubview(sw)
        view.addSubview(imageView)
        view.addSubview(saveButton)
        let safeArea = view.safeAreaLayoutGuide
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: safeArea.layoutFrame.height * 0.7).isActive = true
        
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        sw.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.topAnchor.constraint(equalTo: sw.bottomAnchor, constant: 20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
    
    @objc func save() {
        navigationController?.popViewController(animated: true)
        delegate?.didToggleSwitch(status: sw.isOn)
    }
}

