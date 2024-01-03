//
//  MovieModel.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 31/12/2023.
//

import Foundation

class MovieModel: NSObject {
    
    // MARK: - Welcome
    struct MovieResponse: Codable {
        var page: Int?
        var results: [Result]?
        var totalPages: Int?
        var totalResults: Int?

        enum CodingKeys: String, CodingKey {
            case page = "page"
            case results = "results"
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
    }


    // MARK: - Result
    struct Result: Codable {
        var adult: Bool?
        var backdropPath: String?
        var genreids: [Int]?
        var id: Int?
        var originalLanguage: String?
        var originalTitle: String?
        var overview: String?
        var popularity: Double?
        var posterPath: String?
        var releaseDate: String?
        var title: String?
        var video: Bool?
        var voteAverage: Double?
        var voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult = "adult"
            case backdropPath = "backdrop_path"
            case genreids = "genre_ids"
            case id = "id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview = "overview"
            case popularity = "popularity"
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title = "title"
            case video = "video"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }

    
    enum OriginalLanguage: String, Codable {
        case en = "en"
        case ja = "ja"
    }
}
