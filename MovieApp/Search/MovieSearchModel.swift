//
//  MovieSearchModel.swift
//  MovieApp
//
//  Created by Huda  on 01/01/23.
//



// MARK: - MovieSearchModel
//==========================
struct MovieSearchModel: Codable {
    var page: Int?
    var results: [CommonMovieResult]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

