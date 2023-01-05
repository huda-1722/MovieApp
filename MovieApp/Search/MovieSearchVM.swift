//
//  SearchVM.swift
//  MovieApp
//
//  Created by Huda  on 01/01/23.
//

import Foundation
class MovieSearchVM {
    
    //MARK: PROPERTIES
    //=================================
    private var movieSearch : [CommonMovieResult]?
    private var allSearchMovies : [CommonMovieResult]?
    weak var delegate: RefreshCollectionViewProtocol?
    var pageNo : Int = 1
    private var isNextPageAvailable : Bool = true
    var isSearching : Bool = false
    var localSearchData : [CommonMovieResult]?
    
    //MARK: - Getter Function
    //=============================
    func getRowCount() -> Int {
        return movieSearch?.count ?? 0
    }
    
    func getMovieSearchData(at index : Int) -> CommonMovieResult {
        return movieSearch?[index] ?? CommonMovieResult()
    }
    //MARK: - Fetch Movies
    //=====================
    func hitApi(loader: Bool = true) {
        if isNextPageAvailable {
            self.fetchData(loader: loader)
        }
    }
    //MARK: - FetchSearchData
    //========================
    func fetchSearchData(searchStr : String) {
        localSearchData = allSearchMovies?.filter { $0.title?.lowercased().contains(searchStr.lowercased()) as? Bool ?? false }
        isSearching = true
        if localSearchData?.isEmpty == true {
            let query = searchStr.replacingOccurrences(of: " ", with:  "+").lowercased()
            let params: JSONDictionary = ["api_key" : AppConstant.apikeyValue.rawValue,
                                          "query": query]
            WebServices.movieSearch(params: params) {  [weak self] (response) in
                guard let self = self else { return  }
                switch response {
                case .success(let data):
                    self.updateNewData(list: data.results ?? [CommonMovieResult()])
                    self.delegate?.refreshCollectionView()
                case .failure(let err):
                    print(err.localizedDescription)
                    
                }
            }
        } else {
            movieSearch = localSearchData
            self.delegate?.refreshCollectionView()
        }
        
    }
    //MARK: - Private function
    //=========================
    private func updateNewData(list data:[CommonMovieResult]) {
        for i in 0..<data.count {
            let index = allSearchMovies?.firstIndex(where: {$0.id == data[i].id})
            if index == nil {
                self.allSearchMovies?.append(data[i])
                self.movieSearch?.append(data[i])
            }
        }
    }
    private func fetchData(loader: Bool = true) {
        let params:JSONDictionary = ["page": pageNo,"limit": 10,]
        WebServices.popularMovies(params: params, loader: true) { [weak self] (response) in
            guard let self = self else { return  }
            switch response {
            case .success(let data):
                if self.allSearchMovies == nil {
                    self.allSearchMovies = data.results ?? [CommonMovieResult()]
                    self.movieSearch = self.allSearchMovies
                } else {
                    if let results = data.results {
                        if self.pageNo == 1 {
                            self.movieSearch?.removeAll()
                            self.movieSearch? = results
                        } else {
                            self.updateNewData(list: results)
                        }
                    }
                }
                if (data.totalPages ?? 0) > self.pageNo {
                    self.pageNo += 1
                    self.isNextPageAvailable = true
                } else {
                    self.isNextPageAvailable = false
                }
                
                self.delegate?.refreshCollectionView()
            case .failure(let err):
                print(err.localizedDescription)
                
            }
            
        }
    }
}
