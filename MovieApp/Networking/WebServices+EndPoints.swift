//
//  WebServices+EndPoints.swift
//  MovieApp
//
//  Created by Huda  on 26/12/22.
//

import Foundation
let baseUrl = "https://api.themoviedb.org/3/"
extension WebServices {
    
    enum EndPoint: String {
        case movieDetail = "movie/"
        case nowPlaying = "movie/now_playing?api_key=65e58f60235397a1e0807ad6e508155f&language=en-US&"
        case popluarMovies = "movie/popular?api_key=65e58f60235397a1e0807ad6e508155f&language=en-US&"
        case searchMovie = "search/movie"
        var path: String {
            return baseUrl + self.rawValue
        }
    }
    static func getUrl(with endPoint: EndPoint) -> String {
        return endPoint.path
    }
}

enum ApiKey: String {
    case apikey = "api_key"
    case append_to_response = "append_to_response"
    case authorization = "Authorization"
}
enum AppConstant: String {
    case apikeyValue = "65e58f60235397a1e0807ad6e508155f"
    case credits = "credits"
    case token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NWU1OGY2MDIzNTM5N2ExZTA4MDdhZDZlNTA4MTU1ZiIsInN1YiI6IjYzYTk0NTQ2YWFlYzcxMDBiYjRmMzgyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ot44nzS7i34_5q-668PaRNpV5pI2ethA2Dob_0iiRPc"
}
