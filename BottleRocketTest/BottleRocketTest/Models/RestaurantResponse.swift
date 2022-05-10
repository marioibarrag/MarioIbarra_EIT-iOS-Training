import Foundation

struct RestaurantResponse: Decodable {
    let restaurants: [Restaurant]
}

struct Restaurant: Decodable {
    let name: String
    let backgroundImageURL: String?
    let category: String
    let contact: Contact?
    let location: Location?
}

struct Contact: Decodable {
    let formattedPhone: String?
    let twitter: String?
}

struct Location: Decodable {
    let formattedAddress: [String]?
    let lat: Double?
    let lng: Double?
}
