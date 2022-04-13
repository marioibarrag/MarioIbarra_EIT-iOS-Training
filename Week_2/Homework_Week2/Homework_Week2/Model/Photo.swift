import Foundation

struct Photo: Decodable {
    var photos: [PhotoDetails]
}
//
//enum CodingKeyss: String, CodingKey {
//    case photoItems = "photos"
//}
