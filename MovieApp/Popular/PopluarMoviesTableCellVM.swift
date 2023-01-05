//
//  PopluarMoviesTableCellVM.swift
//  MovieApp
//
//  Created by Huda  on 28/12/22.
//

import Foundation
class PopluarMoviesTableCellVM {
    
    //MARK: PROPERTIES
    //=================================
    private var popluarMovies : PopularMoviesModel?
    private var pageNo : Int = 1
    private var isNextPageAvailable : Bool = true
    weak var delegate: RefreshCollectionViewProtocol?
    
    //MARK: - Getter Function
    //=============================
    func getRowCount() -> Int {
        return popluarMovies?.results?.count ?? 0
        
    }
    func getData(at index: Int) -> CommonMovieResult {
        return popluarMovies?.results?[index] ?? CommonMovieResult()
    }
    //MARK: - FetchPopularMovies
    //=============================
    func hitApi(loader: Bool = true) {
        if isNextPageAvailable {
            self.fetchData(loader: loader)
        }
    }
    
    //MARK: - Private function
    //==========================
    private func updateNewData(list data:[CommonMovieResult]) {
        for i in 0...data.count - 1 {
            self.popluarMovies?.results?.append(data[i])
        }
    }
    private func fetchData(loader: Bool = true) {
        let params:JSONDictionary = ["page": pageNo,"limit": 10,]
        WebServices.popularMovies(params: params, loader: true) { [weak self] (response) in
            guard let self = self else { return  }
            switch response {
            case .success(let data):
                if self.popluarMovies?.results == nil {
                    self.popluarMovies = data
                } else {
                    if let results = data.results {
                        self.updateNewData(list: results)
                    }
                }

                if (data.totalPages ?? 0) > self.pageNo {
                    self.pageNo += 1
                    self.isNextPageAvailable = true
                } else {
                    self.isNextPageAvailable = false
                }
                print(self.popluarMovies?.results ?? [CommonMovieResult]())
                self.delegate?.refreshCollectionView()
                print("dfsdf")
            case .failure(let err):
                print(err.localizedDescription)
                
            }
            
        }
    }
}
