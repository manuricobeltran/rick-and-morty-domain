import Foundation
import Factory

public enum RMDomain {}

public extension RMDomain {
    
    enum Character {
        
        public static var getCharacterInteractor: GetCharacterInteractor {
            Container.shared.getCharacterInteractor()
        }
        
        public static var getCharactersInteractor: GetCharactersInteractor {
            Container.shared.getCharactersInteractor()
        }
        
        public static var getAllCharactersInteractor: GetAllCharactersInteractor {
            Container.shared.getAllCharactersInteractor()
        }
    }
}
