//
//  PopularMoviesModel.swift
//  MovieApp
//
//  Created by Huda  on 28/12/22.
//


import Foundation

// MARK: - PopularMoviesModel for store the pouplarMovoies
//========================================================

struct PopularMoviesModel : Codable {
    var page: Int?
    var results: [CommonMovieResult]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
