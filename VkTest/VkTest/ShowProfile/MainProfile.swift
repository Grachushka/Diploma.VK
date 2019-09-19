import Foundation

struct Welcome: Codable {
    let response: [MainProfile]
}
// MARK: - Response
struct MainProfile: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let photoID: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoID = "photo_id"
    }
}


