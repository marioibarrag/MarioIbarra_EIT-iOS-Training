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
            let pokemonAbilities = [PokemonAbility(ability: PokemonAbility.Ability(name: "overgrow")), PokemonAbility(ability: PokemonAbility.Ability(name: "chlorophyll"))]
            let pokemon = await PokemonData(id: 1, name: "bulbasaur", imgURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", abilities: pokemonAbilities, imgData: try viewModel.networkManager.getData())
            print("POKEMON: \(viewModel.pokemons[0])")
            XCTAssertEqual(pokemon, viewModel.pokemons[0])
            
        } catch {
            XCTFail()
        }
    }
}
