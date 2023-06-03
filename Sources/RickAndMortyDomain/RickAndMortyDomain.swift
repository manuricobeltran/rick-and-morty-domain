import Foundation
import Factory

public enum RMDomain {}

public extension RMDomain {
    
    enum Character {
        static var getCharacterInteractor: GetCharacterInteractor {
            Container.shared.getCharacterInteractor()
        }
    }
}
