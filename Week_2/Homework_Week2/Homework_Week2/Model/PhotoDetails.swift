import Foundation

struct PhotoDetails: Decodable {
    var id: Int
    var img_src: String
    var status: Bool?
}
