//
//  WebServices.swift
//  MovieApp
//
//  Created by Huda  on 26/12/22.
//


import Foundation
import SwiftyJSON
import Alamofire
enum WebServices { }
enum JSONType {
    case jsonDict
    case arrJSON
}
typealias escapingBlock<T:Decodable> = (Result<T,NSError>) -> ()
extension WebServices {
    static func commonGetAPI(parameters: JSONDictionary,
                             headers: HTTPHeaders = [:],
                             endPoint: EndPoint,
                             loader: Bool = true,
                             requireAccesstoken: Bool = true,
                             success: @escaping SuccessResponse,
                             failure: @escaping FailureResponse) {
        
        AppNetworking.GET(endPoint: endPoint.path, parameters: parameters, headers: headers, loader: loader, requireAccesstoken: requireAccesstoken, success: { (json) in
            print(json)
            success(json)
            
            
        }, failure: { (error) -> Void in
            print(error)
            
            failure(error)
        })
    }
    static func commonGetAPI(parameters: JSONDictionary,
                             headers: HTTPHeaders = [:],
                             endPoint: String,
                             loader: Bool = true,
                             requireAccesstoken: Bool = true,
                             success: @escaping SuccessResponse,
                             failure: @escaping FailureResponse) {
        
        AppNetworking.GET(endPoint: endPoint, parameters: parameters, headers: headers, loader: loader, requireAccesstoken: requireAccesstoken, success: { (json) in
            print(json)
            success(json)
            
            
        }, failure: { (error) -> Void in
            print(error)
            
            failure(error)
            //        }
        })
    }
}
extension  WebServices {
    static func getMovieDetails(endpoint : EndPoint, params: JSONDictionary,loader:Bool = true,completion:@escaping (escapingBlock<MovieDetailModel>)) {
        commonGetAPI(parameters: params, endPoint: endpoint) { response in
            parseData(model: MovieDetailModel.self, data: try? response.rawData(), completion: completion)
        } failure: { error in
            completion(.failure(error as NSError))
        }
        
    }
    
    static func getMovieDetails(endpoint : String, params: JSONDictionary,loader:Bool = true,completion:@escaping (escapingBlock<MovieDetailModel>)) {
        commonGetAPI(parameters: params, endPoint: endpoint) { response in
            parseData(model: MovieDetailModel.self, data: try? response.rawData(), completion: completion)
        } failure: { error in
            completion(.failure(error as NSError))
        }
        
    }
    static func movieSearch(params : JSONDictionary,loader: Bool = true,completion: @escaping (escapingBlock<MovieSearchModel>)) {
        commonGetAPI(parameters: params, endPoint: .searchMovie) { response in
            parseData(model: MovieSearchModel.self, data: try? response.rawData(), completion: completion)
        } failure: { error in
            completion(.failure(error as NSError))
        }
    }
    
    static func nowPlayingMovies(params:inout JSONDictionary,loader:Bool = true,completion:@escaping (escapingBlock<NowPlayingModel>)) {
        commonGetAPI(parameters: params, endPoint: .nowPlaying) { response in
            parseData(model: NowPlayingModel.self, data: try? response.rawData(), completion: completion)
        } failure: { error in
            completion(.failure(error as NSError))
        }
        
        
    }
    static func popularMovies(params : JSONDictionary,loader: Bool = true,completion: @escaping (escapingBlock<PopularMoviesModel>)) {
        commonGetAPI(parameters: params, endPoint: .popluarMovies) { response in
            parseData(model: PopularMoviesModel.self, data: try? response.rawData(), completion: completion)
        } failure: { error in
            completion(.failure(error as NSError))
        }
        
    }
}
extension WebServices{
    static func parseData<T:Decodable>(model:T.Type,data:Data?,completion: (Result<T,NSError>) -> ()){
        guard let data = data else {return}
        do{
            let deocder = JSONDecoder()
            //            deocder.keyDecodingStrategy = .convertFromSnakeCase
            let paresd = try deocder.decode(model, from: data)
            completion(.success(paresd))
        }catch let err{
            debugPrint(err)
            completion(.failure(err as NSError))
        }
    }
}
extension NSError {
    
    convenience init(localizedDescription: String) {
        self.init(domain: "AppNetworkingError", code: 0, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
    
    convenience init(code: Int, localizedDescription: String) {
        self.init(domain: "AppNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}

