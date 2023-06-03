import Foundation
import Factory

public enum RMDomain {}

public extension RMDomain {
    
    enum Character {
        
        public static var getCharacterInteractor: GetCharacterInteractor {
            Container.shared.getCharacterInteractor()
        }
    }
}
