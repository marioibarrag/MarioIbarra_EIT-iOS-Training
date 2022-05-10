import Foundation
import Combine

class LunchViewModel {
    
    private var networkManager: NetworkManagerProtocol
    
    @Published private(set) var imageCache: [String: Data] = [:]
    var imgCachePublisher: Published<[String: Data]>.Publisher { $imageCache }
    
    @Published var restaurants: [Restaurant] = []
    var restaurantsPublisher: Published<[Restaurant]>.Publisher { $restaurants }
    
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    func getRestaurants() async {
        networkManager.url = NetworkURLs.restaurantsURL
        do {
            self.restaurants = try await networkManager.getResponseType(RestaurantResponse.self).restaurants
            for restaurant in restaurants {
                guard let backgroundUrl = restaurant.backgroundImageURL else { continue }
                networkManager.url = backgroundUrl
                let imgData = try await networkManager.getData()
                self.imageCache[backgroundUrl] = imgData
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
