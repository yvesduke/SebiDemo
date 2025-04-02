import Foundation

// Add a namespace for the Foods module
extension DrSebi.Modules.Features.Foods {
    struct Food: Decodable, Equatable, Identifiable {
        let id: Int
        let name: String
        
        init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
    }
} 