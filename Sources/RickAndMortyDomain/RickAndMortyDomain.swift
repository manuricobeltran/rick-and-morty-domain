import Foundation
import Factory

public struct RMDomain {
    
    init() {
        // Intentionally empty
    }
}

public extension RMDomain {
    
    static var getCharacterInteractor: GetCharacterInteractor {
        Container.shared.getCharacterInteractor()
    }
}
