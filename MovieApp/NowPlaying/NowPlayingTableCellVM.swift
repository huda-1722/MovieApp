//
//  NowPlayingTableCellVM.swift
//  MovieApp
//
//  Created by Huda  on 27/12/22.
//

import Foundation
class NowPlayingTableCellVM {
    
    //MARK: PROPERTIES
    //=================================
    private var nowPlayingArray : NowPlayingModel?
    private var pageNo : Int = 1
    private var isNextPageAvailable : Bool = true
    weak var delegate: RefreshCollectionViewProtocol?
    
    //MARK: - Getter Function
    //=============================
    func getRowCount() -> Int {
        return nowPlayingArray?.results?.count ?? 0
        
    }
    func getData(at index: Int) -> CommonMovieResult {
        return nowPlayingArray?.results?[index] ?? CommonMovieResult()
    }
    //MARK: - fetchNowPlayingMovies
    //================================
    func hitApi(loader: Bool = true) {
        if isNextPageAvailable {
            self.fetchData(loader: loader)
        }
    }
    //MARK: - Private function
    //==========================
    private func updateNewData(list data:[CommonMovieResult]) {
        for i in 0...data.count - 1 {
            self.nowPlayingArray?.results?.append(data[i])
        }
    }
    private func fetchData(loader: Bool = true) {
        var params:JSONDictionary = ["page": pageNo,"limit": 10,]
        WebServices.nowPlayingMovies(params: &params, loader: true) { [weak self] (response) in
            guard let self = self else { return  }
            switch response {
            case .success(let data):
                if self.nowPlayingArray?.results == nil {
                    self.nowPlayingArray = data
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
                self.delegate?.refreshCollectionView()
                print("dfsdf")
            case .failure(let err):
                print(err.localizedDescription)
                
            }
        }
    }
}
