import Foundation
@testable import PocketMonster

final class MockNetworkManager: NetworkManagerProtocol {
    var url: String = ""
    
    func getResponseType<ResponseType>(_ type: ResponseType.Type) async throws -> ResponseType where ResponseType : Decodable {
        let data: Data
        if type == PokemonResponse.self {
            data = loadFileData(filename: "pokemon_response")
            
        } else {
            data = loadFileData(filename: "pokemon_detail")
        }
        
        let result = try JSONDecoder().decode(ResponseType.self, from: data)
        return result
    }
    
    func loadFileData(filename: String ) -> Data  {
        
        let bundle = Bundle(for: MockNetworkManager.self)
        print(bundle)
        guard let url = bundle.url(forResource: filename, withExtension: "json")
        else { return Data() }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            return Data()
        }
    }
    
    func getData() async throws -> Data {
        return Data()
    }
    
    func createURL() throws -> URL {
        guard let url = URL(string: "https://www.google.com")
            else { throw NSError(domain: "url error", code: 500) }
        return url
    }
    
    
}
