import Foundation

protocol NetworkManagerProtocol {
    var url: String { get set }
    func getResponseType<ResponseType: Decodable>(_ type: ResponseType.Type) async throws -> ResponseType
    func getData() async throws -> Data
    func createURL() throws -> URL
}

final class NetworkManager: NetworkManagerProtocol {
    var url = ""
    
    final func getResponseType<ResponseType: Decodable>(_ type: ResponseType.Type) async throws -> ResponseType {
        let data = try await getData()
        let result = try JSONDecoder().decode(ResponseType.self, from: data)
        return result
    }
    
    final func getData() async throws -> Data {
        let url = try createURL()
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func createURL() throws -> URL {
        guard let url =  URL(string: self.url) else {
            throw NSError(domain: "Error creating URL", code: 500)
        }
        return url
    }
}
