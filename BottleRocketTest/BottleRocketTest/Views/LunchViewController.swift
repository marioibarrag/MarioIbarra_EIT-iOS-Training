//
//  ViewController.swift
//  BottleRocketTest
//
//  Created by Consultant on 5/8/22.
//

import UIKit
import Combine

class LunchViewController: UIViewController {
    
    private var subscribers = Set<AnyCancellable>()
    
    private let viewModel = LunchViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: 180)
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RestaurantCell.self, forCellWithReuseIdentifier: RestaurantCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpBinding()
    }
    
    private func setUpBinding() {
        viewModel
            .$restaurants
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in
                self.collectionView.reloadData()
            })
            .store(in: &subscribers)
        
        viewModel
            .$imageCache
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in
                self.collectionView.reloadData()
            })
            .store(in: &subscribers)
        
        Task {
            await viewModel.getRestaurants()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    func setUpView() {
        view.addSubview(collectionView)
        let safeArea = view.safeAreaLayoutGuide
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
}

extension LunchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { viewModel.restaurants.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCell.id, for: indexPath) as! RestaurantCell
        cell.configureCell(restaurantName: viewModel.restaurants[indexPath.row].name, category: viewModel.restaurants[indexPath.row].category, imgData: viewModel.imageCache[viewModel.restaurants[indexPath.row].backgroundImageURL ?? ""] ?? Data())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurantDetailVC = RestaurantDetailViewController()
        let row = indexPath.row
        guard let location = viewModel.restaurants[row].location, let lat = location.lat, let lng = location.lng
        else { return }
        restaurantDetailVC.configDetailsVC(lat: lat, lng: lng, restaurant: viewModel.restaurants[row])
        navigationController?.pushViewController(restaurantDetailVC, animated: true)
    }
}
