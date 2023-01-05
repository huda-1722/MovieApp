//
//  MovieSearchVC.swift
//  MovieApp
//
//  Created by Huda  on 01/01/23.
//

import UIKit

class MovieSearchVC: UIViewController {
    
    // MARK: - IBOutlets
    //=====================================
    @IBOutlet weak var searchMovieCollectionView: UICollectionView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    //MARK: PROPERTIES
    //=================================
    private var viewModel : MovieSearchVM?
   
    
    // MARK: - Lifecycle
    //====================================
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
       

        // Do any additional setup after loading the view.
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
//=============================================================
extension MovieSearchVC : UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.getRowCount() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieSearchCell = collectionView.dequeueCell(with: MovieSearchCollectionCell.self, for: indexPath)
        let getData = viewModel?.getMovieSearchData(at : indexPath.item)
        movieSearchCell.populateData(data: getData ?? CommonMovieResult())
        return movieSearchCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 , height:  collectionView.frame.width/2 + 80 )
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (self.viewModel?.getRowCount() ?? 0) - 2 && viewModel?.isSearching == false {
            self.viewModel?.hitApi()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - Extension for Private functions
//========================================
extension MovieSearchVC {
    private func initialSetUp() {
        setupViewModel(vm: MovieSearchVM())
        setUpCollectionView()
        hideKeyBoard()
    }
    private func setupViewModel(vm : MovieSearchVM) {
        guard self.viewModel == nil else { return }
        viewModel = vm
        viewModel?.delegate = self
        viewModel?.hitApi()
    }
    private func setUpCollectionView() {
        searchMovieCollectionView.delegate = self
        searchMovieCollectionView.dataSource = self
        movieSearchBar.delegate = self
        searchMovieCollectionView.registerCell(with: MovieSearchCollectionCell.self)
    }
    private func hideKeyBoard() {
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
// MARK: - Extension of UISearchBarDelegate
//========================================
extension MovieSearchVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel?.pageNo = 1
            viewModel?.isSearching = false
            viewModel?.hitApi()
        } else {
        viewModel?.fetchSearchData(searchStr: searchText)
        }
    }
}
// MARK: - Extension of RefreshCollectonView
//==========================================
extension MovieSearchVC: RefreshCollectionViewProtocol {
    func refreshCollectionView() {
        searchMovieCollectionView.reloadData()
    }
}


