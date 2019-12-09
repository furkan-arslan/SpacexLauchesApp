import Foundation

struct LaunchData: Codable {
    let flightNumber: Int!
    let rocket: LaunchingRocket!
    let mission_name: String!
    let launch_year: String!
    let launchDateUTC: String?
    let links: Links!
    let details: String?

    private enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case rocket = "rocket"
        case mission_name = "mission_name"
        case launch_year = "launch_year"
        case launchDateUTC = "launch_date_utc"
        case links = "links"
        case details = "details"
    }
}


struct LaunchingRocket: Codable {
    let rocket_id: String?
    let rocket_name: String?
    let rocket_type: String?

    private enum CodingKeys: String, CodingKey {
        case rocket_id = "rocket_id"
        case rocket_name = "rocket_name"
        case rocket_type = "rocket_type"
    }
}

struct Links: Codable {
    let mission_patch: String?
    let mission_patch_small: String?

    private enum CodingKeys: String, CodingKey {
        case mission_patch = "mission_patch"
        case mission_patch_small = "mission_patch_small"
    }
}
