//
//  MovieModel.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 31/12/2023.
//

import Foundation

class MovieModel: NSObject {
    
    // MARK: - MFA Recent DeviceList ByUsername
    struct MovieType: Codable {
        let id: String?
        let name: String?

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
        }
    }
}
