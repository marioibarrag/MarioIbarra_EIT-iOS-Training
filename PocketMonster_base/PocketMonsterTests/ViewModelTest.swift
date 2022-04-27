@testable import PocketMonster
import XCTest

class ViewModelTest: XCTestCase {

    private var viewModel: PokemonListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = PokemonListViewModel(networkManager: MockNetworkManager())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_pokemons_did_load_from_api() async {
        do {
            try await viewModel.loadPokemons()
            XCTAssertEqual(viewModel.pokemons[0].name, "bulbasaur")
        } catch {
            XCTFail()
        }
    }
}
