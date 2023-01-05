//
//  MovieDeatilVM.swift
//  MovieApp
//
//  Created by Huda  on 28/12/22.
//

import Foundation

protocol PassMovieData: NSObject {
    func didGetMovieData()
}
class MovieDeatilVM {
    
    //MARK: PROPERTIES
    //=================================
    private var movieDeatil : MovieDetailModel?
    weak var delegate : PassMovieData?
    
    init(movieId : Int) {
        fetchMovieDetail(movieId: movieId)
    }
    //MARK: - Getter Function
    //=============================
    func getData() -> MovieDetailModel {
        return movieDeatil ?? MovieDetailModel()
    }
    //MARK: - Private function for fetchMovieDetails
    //==============================================
    private func fetchMovieDetail(movieId : Int) {
        
        let params:JSONDictionary = [ApiKey.apikey.rawValue : AppConstant.apikeyValue.rawValue,ApiKey.append_to_response.rawValue : AppConstant.credits.rawValue]
        let urlString = WebServices.getUrl(with: .movieDetail) + "\(movieId)"
        WebServices.getMovieDetails(endpoint : urlString, params: params, loader: true) { [weak self] (response) in
            DispatchQueue.main.async {
                guard let self = self else { return  }
                switch response {
                case .success(let data):
                    self.movieDeatil = data
                    self.delegate?.didGetMovieData()
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
}
