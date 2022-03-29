//
//  ViewController.swift
//  picsum_app
//
//  Created by Consultant on 3/29/22.
//

import UIKit

class ViewController: UIViewController {

    var imageView = UIImageView()
    var button = UIButton()
    var baseURL = "https://picsum.photos"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(button)
        view.addSubview(imageView)
        
        setupButton()
        setupImageView()
    }
    
    private func setupButton() {
        button.setTitle("Get Image", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.getImageFromURL), for: .touchUpInside)
        
        let safeArea = view.safeAreaLayoutGuide
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15).isActive = true
        button.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
    }
    
    private func setupImageView() {
        imageView.backgroundColor = .lightGray
        
        let safeArea = view.safeAreaLayoutGuide
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -15).isActive = true
    }
    
    
    
    @objc func getImageFromURL() {
        let url = URL(string: baseURL + "/\(Int(imageView.frame.width))/\(Int(imageView.frame.height))")
        if let data = try? Data(contentsOf: url!) {
                // Create Image and Update Image View
                imageView.image = UIImage(data: data)
            }
    }

}

